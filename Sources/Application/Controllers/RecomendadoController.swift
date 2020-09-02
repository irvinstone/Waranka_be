//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM
import Foundation


class RecomendadoController {
    
    static func createHandler(recomendado: Recomendado,completion: @escaping (Recomendado?, RequestError?) -> Void) {
        recomendado.save { data, error in
            if let err = error {
                completion(nil,RequestError(.conflict, body: err.description))
            }
            completion(data,nil)
        }
    }
    
    
    static func findAllHandler(params:Params?,completion: @escaping ([Recomendado]?, RequestError?) -> Void) {
        
        Recomendado.findAll(matching: params, {data , error in
            if let err = error {
                if err.rawValue == 707 {
                    completion([], nil)
                } else {
                    completion(nil,RequestError(.internalServerError, body: err.description))
                }
            } else {
                completion(data,nil)
            }
        })
    }
    
    static func findHandler(id: Int, completion: @escaping (RecomendadoClass?, RequestError?) -> Void) {
        
        Recomendado.find(id: id, { data , error in
            if let err = error {
                if err.rawValue == 707 {
                    completion(nil, nil)
                } else {
                    completion(nil,RequestError(.internalServerError, body: err.description))
                }
            } else {
                let recomendado = RecomendadoClass(telefono: data?.telefono, direccion: data?.direccion, nombres: data?.nombres, apellidos: data?.apellidos, foto: data?.foto, descripcion: data?.descripcion, atributos: [])
                var atrs: [Atributo?] = []
                let param = TelefonoParam(telefono:recomendado.telefono)
                let group = DispatchGroup()
                group.enter()
                Atributo.findAll (matching: param,{ data , error in
                    if let err = error {
                        print(err.description)
                        recomendado.setAtributos(attr: [])
                    } else {
                        atrs = data ?? []
                        recomendado.setAtributos(attr: atrs)
                    }
                    group.leave()
                    
                })
                
                group.enter()
                Oficio.find (id: data?.oficio_id ?? 0,{ data , error in
                    if let err = error {
                        print(err.description)
                        recomendado.setOficio(oficio: nil)
                    } else {
                        recomendado.setOficio(oficio: data)
                    }
                    group.leave()
                })
                
                group.enter()
                Distrito.find (id: data?.oficio_id ?? 0,{ data , error in
                    if let err = error {
                        print(err.description)
                        recomendado.setDistrito(distrito: nil)
                    } else {
                        recomendado.setDistrito(distrito: data)
                    }
                    group.leave()
                })
                
                group.wait()
                completion(recomendado,nil)
            }
        })
    }
}
