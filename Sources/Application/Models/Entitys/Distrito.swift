//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM
import SwiftKuery

struct Distrito : Codable {
    let distrito_id: Int
    let nombre: String
}

struct FilterParams: QueryParams {
    let by: String
}


extension Distrito : Model {
    static var tableName: String = "distrito"
    static var idColumnName: String = "distrito_id"

    public static func filter(by: String ,oncompletion: @escaping ([Distrito?]?, RequestError?)-> Void) {

        guard let table = try? Distrito.getTable() else {
            return oncompletion(nil,nil)
        }
        let query = Select(from: table).where("nombre LIKE '%\(by)%'")
        Distrito.executeQuery(query: query, parameters: nil, oncompletion)
    }
}
