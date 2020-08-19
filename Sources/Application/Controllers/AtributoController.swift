//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM

class AtributoController {
    static func createHandler(atributo: Atributo,completion: @escaping (Atributo?, RequestError?) -> Void) {
        atributo.save { data, error in
            if let err = error {
                completion(nil,RequestError(.conflict, body: err.description))
            }
            completion(data,nil)
        }
    }
}

