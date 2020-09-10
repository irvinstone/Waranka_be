//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/3/20.
//

import Foundation

protocol SensibleClass: Codable {
    var telefono: Int { get set }
    func accept(visitor: Visitor) -> SensibleClass
}
