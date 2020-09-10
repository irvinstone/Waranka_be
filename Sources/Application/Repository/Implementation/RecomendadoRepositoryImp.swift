//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/2/20.
//

import SwiftKueryORM
import Foundation

class RecomendadoRepositoryImp: RecomendadoRepository {
    
    let dispatchGroup = DispatchGroup()
    let semaphore = DispatchSemaphore(value: 0)
    
    func save(recomendado: Recomendado) -> Recomendado? {
        var saved : Recomendado?
        recomendado.save { data, error in
            if let err = error {
                print(err.description)
            }else {
                saved = data
            }
            self.semaphore.signal()
        }
        
        semaphore.wait()
        return saved
    }
    
    func findAll(params: Params?) -> [RecomendadoClass?] {
        var recomendados : [RecomendadoClass?] = []
        Recomendado.findAllRelations { data, error in
            if let err = error {
                print(err.description)
            }else {
                recomendados = data
            }
            self.semaphore.signal()
        }
        semaphore.wait()
        return recomendados
        
    }
    
    func findOne(id: Int)-> RecomendadoClass? {
        return queryOne(id: id)
    }
    
    private func queryOne(id: Int) -> RecomendadoClass? {
        var recomendado: RecomendadoClass?
        var recomendadData: Recomendado?
        
        Recomendado.find(id: id, { data, error in
            if let err = error {
                print(err.description)
            } else {
                recomendado = RecomendadoClass(id: data?.recomendado_id ?? 0, nombres: data?.nombres ?? "", apellidos: data?.apellidos ?? "", telefono: data?.telefono ?? 0, direccion: data?.direccion ?? "", foto: data?.foto ?? "", descripcion: data?.descripcion ?? "", atributos: [], distrito: nil, oficio: nil)
                recomendadData = data
                
            }
            self.semaphore.signal()
            
        })
        semaphore.wait()
        
        var atrs: [Atributo?] = []
        let param = RecomendadoParam(telefono:id)
        
        dispatchGroup.enter()
        Atributo.findAll (matching: param,{ data , error in
            if let err = error {
                print(err.description)
            } else {
                atrs = data ?? []
                recomendado?.setAtributos(attr: atrs)
            }
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        Oficio.find (id: recomendadData?.oficio_id ?? 0,{ data , error in
            if let err = error {
                print(err.description)
            } else {
                recomendado?.setOficio(oficio: data)
            }
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        Distrito.find (id: recomendadData?.distrito_id ?? 0,{ data , error in
            if let err = error {
                print(err.description)
            } else {
                recomendado?.setDistrito(distrito: data)
            }
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.wait()
        return recomendado

    }
    
}
