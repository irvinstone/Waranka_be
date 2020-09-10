//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/2/20.
//

import SwiftKueryORM

struct ListaRecomendado : Codable {
    var lista_recomendado_id: Int?
    var lista_id :Int
    var recomendado_id: Int
}

struct ListaRecomendadoParams: QueryParams {
    let lista_id: Int?
}

extension ListaRecomendado : Model {
    static var tableName: String = "lista_recomendado"
    static var idColumnName: String = "lista_recomendado_id"
    
}

