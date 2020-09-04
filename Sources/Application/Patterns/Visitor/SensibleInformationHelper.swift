//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/3/20.
//

import Foundation

class SensibleInformationHelper: Visitor {
    
    func hideSensibleInformation(data:[SensibleEntity?],colection: Collection) -> [SensibleEntity?] {
        
        let iterator = colection.createIterator()
        var publicData: [SensibleEntity?] = []
        
        while iterator.hasNext() {
            let element = iterator.next()
            if let item = element?.accept(visitor: self) {
                publicData.append(item)
            }
        }
        return publicData
        
    }
    
    func visitRecomendado(recomendado: Recomendado) -> Recomendado {
        var new = recomendado
        new.telefono = 0
        return new
    }
    
    func visitUser(recomendado: User) -> User {
        var new = recomendado
        new.telefono = 0
        return new
    }
}
