//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM


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
                var atrs: [Atributo?] = []
                Atributo.findAll { data , error in
                    if let err = error {
                        if err.rawValue == 707 {
                            atrs = []
                        } else {
                            completion(nil,RequestError(.internalServerError, body: err.description))
                        }
                    } else {
                        atrs = data ?? []
                        let recomendado = RecomendadoClass(name: "", atributos: atrs)
                        completion(recomendado,nil)
                    }
                }
            }
        })
    }
}
