//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/3/20.
//

import Foundation

class RecomendadoIterator: Iterator {
    
    let elements : [RecomendadoClass?]
    var position : Int
    
    init(recomendados: [RecomendadoClass?]) {
        self.elements = recomendados
        self.position = 0
    }
    
    func hasNext() -> Bool {
        if position <= elements.count - 1 {
            return true
        }
        return false
    }
    
    func next() -> RecomendadoClass? {
        if hasNext() {
            let item = elements[position]
            position += 1
            return item
        }
        return nil
    }
}
