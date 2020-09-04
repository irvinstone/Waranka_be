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
    
    func findAll(params: Params?) -> [Recomendado?] {
        
        var recomendados : [Recomendado?] = []
        dispatchGroup.enter()
        Recomendado.findAll(matching: params, {data , error in
            if let err = error {
                if err.rawValue == 707 {
                    recomendados = []
                } else {
                    recomendados = []
                }
            } else {
                recomendados = data ?? []
            }
            self.dispatchGroup.leave()
        })
        dispatchGroup.wait()
        return recomendados
        
    }
    
    func findOne(id: Int)-> RecomendadoClass? {
        
        var recomendado: RecomendadoClass?
        var recomendadData: Recomendado?
        
        Recomendado.find(id: id, { data, error in
            if let err = error {
                print(err.description)
            } else {
                recomendado = RecomendadoClass(telefono: data?.telefono, direccion: data?.direccion, nombres: data?.nombres, apellidos: data?.apellidos, foto: data?.foto, descripcion: data?.descripcion, atributos: [])
                recomendadData = data
            }
            self.semaphore.signal()
            
        })
        semaphore.wait()
        
        var atrs: [Atributo?] = []
        let param = TelefonoParam(telefono:id)
        
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
