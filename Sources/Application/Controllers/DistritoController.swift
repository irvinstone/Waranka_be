//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM

class DistritoController {
    
    static func findAllHandler(completion: @escaping ([Distrito]?, RequestError?) -> Void) {
        Distrito.findAll { data , error in
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
    
    static func filterHandler(params: FilterParams,completion: @escaping ([Distrito?]?, RequestError?) -> Void) {
        
        Distrito.filter(by: params.by, oncompletion: { data , error in
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
}
