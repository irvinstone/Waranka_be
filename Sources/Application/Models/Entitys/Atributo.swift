//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM

struct Atributo: Codable {
    let valor: String
//    let fecha: String
    let atributo_id: Int
    let telefono: Int
}

struct TelefonoParam: QueryParams {
    let telefono: Int?
    init(telefono: Int) {
        self.telefono = telefono
    }
}

extension Atributo: Model {
    static var tableName: String = "recomendado_atributo"
    static var idColumnName: String = "recomendado_atributo_id"
}
