//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM

struct Oficio : Codable {
    let oficio_id: Int?
    let categoria_id: Int
    let nombre: String
    let descripcion: String
}

extension Oficio: Model {
    static var tableName: String = "oficio"
    static var idColumnName: String = "oficio_id"
}
