//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM
import Foundation


class RecomendadoController {
    
    let recomendadoRepository: RecomendadoRepository
    
    //- Singleton
    static let Shared = RecomendadoController()
    
    private init() {
        recomendadoRepository = RecomendadoRepositoryImp()
    }
    
    func createHandler(recomendado: Recomendado,completion: @escaping (Recomendado?, RequestError?) -> Void) {
        completion(recomendadoRepository.save(recomendado: recomendado),nil)
    }
    
    
    func findAllHandler(params:Params?,completion: @escaping ([RecomendadoClass?]?, RequestError?) -> Void) {
        
        let recomendadosClass       = recomendadoRepository.findAll(params: params)
        let collection: Collection  = RecomendadoCollection(recomendados: recomendadosClass)
        let helper                  = SensibleInformationHelper()
        
        //Visitor
        if let recomendados = helper.hideSensibleInformation(data: recomendadosClass, colection: collection) as? [RecomendadoClass?] {
            completion(recomendados,nil)
        }
        else {
            completion(nil,RequestError(.internalServerError, body: "internal error"))
        }
    }
    
    func findHandler(id: Int, completion: @escaping (RecomendadoClass?, RequestError?) -> Void) {
        completion(recomendadoRepository.findOne(id: id),nil)
    }
}
