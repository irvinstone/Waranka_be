//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/15/20.
//

import SwiftKueryORM


struct User: Codable, SensibleEntity {
    var usuario_id: Int?
    let nombres: String
    let apellidos: String
    let edad: Int
    let email: String
    let contrasena: String
    var telefono: Int
    let estado: Int
    let profile_id: Int
    
    func accept(visitor: Visitor) -> SensibleEntity {
        return visitor.visitUser(recomendado: self)
    }
}

extension User : Model {
    static var tableName: String = "usuario"
    static var idColumnName: String = "usuario_id"
}

