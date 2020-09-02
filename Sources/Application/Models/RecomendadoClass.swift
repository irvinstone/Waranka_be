//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import Foundation

class RecomendadoClass: Codable {
    var telefono :Int
    var direccion: String
    var nombres: String
    var apellidos: String
    var foto: String
    var descripcion: String
    var atributos: [Atributo?]
    var distrito: Distrito?
    var oficio: Oficio?
    
    init(telefono: Int?,direccion: String?, nombres: String?, apellidos: String?, foto: String?, descripcion: String?, atributos: [Atributo?]) {
        self.telefono = telefono ?? 0
        self.direccion = direccion ?? ""
        self.nombres =  nombres ?? ""
        self.apellidos = apellidos ?? ""
        self.foto = foto ?? ""
        self.descripcion = descripcion ?? ""
        self.atributos = atributos
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
}
