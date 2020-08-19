//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import Foundation

class RecomendadoClass: Codable {
    let name: String
    let atributos: [Atributo?]
    
    init(name: String, atributos: [Atributo?]) {
        self.name = name
        self.atributos = atributos
    }
}
