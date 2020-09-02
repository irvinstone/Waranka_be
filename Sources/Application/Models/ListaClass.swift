//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/2/20.
//

import Foundation

class ListaClass: Codable {
    
    var nombre: String
    var descripcion: String
    var estado: Int
    var recomendados: [Recomendado?]
    
    init(nombre: String?,descripcion: String?, estado: Int?, recomendados: [Recomendado?]) {
        self.nombre = nombre ?? ""
        self.descripcion = descripcion ?? ""
        self.estado = estado ?? 1
        self.recomendados = recomendados
    }
    
    func setRecomendados(recoms: [Recomendado?]) {
        self.recomendados = recoms
    }
}
