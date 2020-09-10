//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/3/20.
//

import Foundation

class SensibleInformationHelper: Visitor {
    
    func hideSensibleInformation(data:[SensibleClass?],colection: Collection) -> [SensibleClass?] {
        
        //Iterator
        let iterator = colection.createIterator()
        var publicData: [SensibleClass?] = []
        
        while iterator.hasNext() {
            let element = iterator.next()
            if let item = element?.accept(visitor: self) {
                publicData.append(item)
            }
        }
        return publicData
        
    }
    
    func visitRecomendado(recomendado: RecomendadoClass) -> RecomendadoClass {
        let new = recomendado
        new.telefono = 0
        return new
    }
    
    func visitUser(recomendado: UserClass) -> UserClass {
        let new = recomendado
        new.telefono = 0
        return new
    }
}
