//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM

struct Recomendado : Codable {
    var telefono :Int
    var user_id: Int
    var oficio_id: Int
    var distrito_id: Int
    var direccion: String
    var nombres: String
    var apellidos: String
    var foto: String
    var descripcion: String
}

struct Params: QueryParams {
    let distrito_id: Int?
    let oficio_id: Int?
}

extension Recomendado : Model {
    static var tableName: String = "recomendado"
    static var idColumnName: String = "telefono"
    
}
