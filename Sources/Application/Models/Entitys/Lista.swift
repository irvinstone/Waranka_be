//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/2/20.
//

import SwiftKueryORM

struct Lista : Codable {
    var lista_id :Int?
    var nombre: String
    var descripcion: String
    var estado: Int
    var user_id: Int
}

struct ListaParams: QueryParams {
    let user_id: Int?
}

extension Lista : Model {
    static var tableName: String = "lista"
    static var idColumnName: String = "lista_id"
    
}
