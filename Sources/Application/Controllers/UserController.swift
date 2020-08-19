//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/15/20.
//

import SwiftKueryORM

class UserController {
    
    static func createHandler(user: User,completion: @escaping (User?, RequestError?) -> Void) {
        user.save { data, error in
            if let err = error {
                completion(nil,RequestError(.conflict, body: err.description))
            }
            completion(data,nil)
        }
    }
    
    static func findAllHandler(completion: @escaping ([User]?, RequestError?) -> Void) {
        User.findAll { data , error in
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
    
    static func findHandler(id: Int, completion: @escaping (User?, RequestError?) -> Void) {
        
        User.find(id: id, { data , error in
            if let err = error {
                if err.rawValue == 707 {
                    completion(nil, nil)
                } else {
                    completion(nil,RequestError(.internalServerError, body: err.description))
                }
            } else {
                completion(data,nil)
            }
        })
    }
}
    
