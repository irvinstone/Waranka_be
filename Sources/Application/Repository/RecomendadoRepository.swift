//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/2/20.
//

import Foundation

protocol RecomendadoRepository {
    
    func save(recomendado: Recomendado) -> Recomendado?
    func findAll(params: Params?) -> [Recomendado?]
    func findOne(id: Int)-> RecomendadoClass?
}
