//
//  File.swift
//
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM
import Foundation


class ListaController {
    
    static func createHandler(lista: Lista,completion: @escaping (Lista?, RequestError?) -> Void) {
        lista.save { data, error in
            if let err = error {
                completion(nil,RequestError(.conflict, body: err.description))
            }
            completion(data,nil)
        }
    }
    
    static func addToListHandler(listaRecomendado: ListaRecomendado,completion: @escaping (ListaRecomendado?, RequestError?) -> Void) {
        listaRecomendado.save { data, error in
            if let err = error {
                completion(nil,RequestError(.conflict, body: err.description))
            }
            completion(data,nil)
        }
    }
    
    
    static func findAllHandler(params:ListaParams?,completion: @escaping ([Lista]?, RequestError?) -> Void) {
        
        Lista.findAll(matching: params, {data , error in
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
    
    static func findHandler(id: Int, completion: @escaping (ListaClass?, RequestError?) -> Void) {
        
        Lista.find(id: id, { data , error in
            if let err = error {
                if err.rawValue == 707 {
                    completion(nil, nil)
                } else {
                    completion(nil,RequestError(.internalServerError, body: err.description))
                }
            } else {
                let params = ListaRecomendadoParams(lista_id: data?.lista_id)
                let listClass = ListaClass(nombre: data?.nombre, descripcion: data?.descripcion, estado: data?.estado, recomendados: [])
                ListaRecomendado.findAll(matching: params, {data , error in
                    if let err = error {
                        print(err.description)
                        listClass.setRecomendados(recoms: [])
                        completion(listClass,nil)
                    } else {
                        let dispatchGroup = DispatchGroup()
                        
                        let recoms2 = data.map{ (listRecomend: [ListaRecomendado]) -> [Recomendado?] in
                            return listRecomend.compactMap { (lr: ListaRecomendado) in
                                dispatchGroup.enter()
                                var recomendado: Recomendado?
                                Recomendado.find(id: lr.telefono, { data , error in
                                    if let err = error {
                                        print(err)
                                    } else {
                                        recomendado = data
                                    }
                                    dispatchGroup.leave()
                                })
                                dispatchGroup.wait()
                                return recomendado
                            }
                        }
                        listClass.setRecomendados(recoms: (recoms2 ?? [])!)
                        completion(listClass,nil)
                    }
                })

            }
        })
    }
}
