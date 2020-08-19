//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM

final class Oficio : Codable {
    let oficio_id: Int?
    let nombre: String
    let descripcion: String
}

extension Oficio: Model {
    static var tableName: String = "oficio"
    static var idColumnName: String = "oficio_id"
}
