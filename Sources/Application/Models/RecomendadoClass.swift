//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import Foundation

class RecomendadoClass: Codable , SensibleClass{
    var id: Int
    var telefono :Int
    var direccion: String
    var nombres: String
    var apellidos: String
    var foto: String
    var descripcion: String
    var atributos: [Atributo?]
    var distrito: Distrito?
    var oficio: Oficio?
    
    init(id: Int,nombres: String, apellidos: String, telefono: Int, direccion: String,foto: String, descripcion: String, atributos: [Atributo?], distrito: Distrito? = nil, oficio: Oficio? = nil) {
        self.id = id
        self.nombres = nombres
        self.apellidos = apellidos
        self.telefono = telefono
        self.direccion = direccion
        self.nombres = nombres
        self.apellidos = apellidos
        self.foto = foto
        self.descripcion = descripcion
        self.atributos = atributos
        self.distrito = distrito
        self.oficio = oficio
    }
    
    
    func setAtributos(attr: [Atributo?]) {
        self.atributos = attr
    }
    func setOficio(oficio: Oficio?) {
        self.oficio = oficio
    }
    func setDistrito(distrito: Distrito?) {
        self.distrito = distrito
    }
    
    func accept(visitor: Visitor) -> SensibleClass {
        return visitor.visitRecomendado(recomendado: self)
    }
}
