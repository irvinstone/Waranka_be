//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/3/20.
//

import Foundation

class RecomendadoCollection: Collection {
    
    let recomendados: [RecomendadoClass?]
    
    init(recomendados: [RecomendadoClass?]) {
        self.recomendados = recomendados
    }
    
    func createIterator() -> Iterator {
        return RecomendadoIterator(recomendados: recomendados)
    }
}
