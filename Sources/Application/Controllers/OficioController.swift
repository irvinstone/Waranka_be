//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM

class OficioController {
    
    static func createHandler(oficio: Oficio,completion: @escaping (Oficio?, RequestError?) -> Void) {
        oficio.save { data, error in
            if let err = error {
                completion(nil,RequestError(.conflict, body: err.description))
            }
            completion(data,nil)
        }
    }
    
    static func findAllHandler(completion: @escaping ([Oficio]?, RequestError?) -> Void) {
        Oficio.findAll { data , error in
            if let err = error {
                if err.rawValue == 707 {
                    completion([], nil)
                } else {
                    completion(nil,RequestError(.internalServerError, body: err.description))
                }
            } else {
                completion(data,nil)
            }
        }
    }
}
