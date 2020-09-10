//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/2/20.
//

import Foundation

protocol Iterator {
    func hasNext() -> Bool
    func next() -> RecomendadoClass?
}
