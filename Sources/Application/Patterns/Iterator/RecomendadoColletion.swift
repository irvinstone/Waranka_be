//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/3/20.
//

import Foundation

class RecomendadoCollection: Collection {
    
    let recomendados: [Recomendado?]
    
    init(recomendados: [Recomendado?]) {
        self.recomendados = recomendados
    }
    
    func createIterator() -> Iterator {
        return RecomendadoIterator(recomendados: recomendados)
    }
}
