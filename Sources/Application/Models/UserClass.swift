//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/10/20.
//

import Foundation

class UserClass: Codable,SensibleClass {
    
    var usuario_id: Int
    var telefono: Int
    let edad: Int
    let email: String
    let direccion: String
    let nombres: String
    let apellidos: String
    
    internal init(usuario_id: Int, telefono: Int, edad: Int, email: String, direccion: String, nombres: String, apellidos: String) {
        self.usuario_id = usuario_id
        self.telefono = telefono
        self.edad = edad
        self.email = email
        self.direccion = direccion
        self.nombres = nombres
        self.apellidos = apellidos
    }
    
    func accept(visitor: Visitor) -> SensibleClass {
        return visitor.visitUser(recomendado: self)
    }
}
