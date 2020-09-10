//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/3/20.
//

import Foundation

protocol Visitor {
    func visitRecomendado(recomendado: RecomendadoClass) -> RecomendadoClass
    func visitUser(recomendado: UserClass) -> UserClass
}
