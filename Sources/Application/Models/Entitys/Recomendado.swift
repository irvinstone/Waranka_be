//
//  File.swift
//  
//
//  Created by Irvin Leon on 8/16/20.
//

import SwiftKueryORM
import SwiftKuery
import  Foundation

struct Recomendado : Codable {
    var recomendado_id: Int?
    var telefono :Int
    var user_id: Int
    var oficio_id: Int
    var distrito_id: Int
    var direccion: String
    var nombres: String
    var apellidos: String
    var foto: String
    var descripcion: String
}

struct Params: QueryParams {
    let distrito_id: Int?
    let oficio_id: Int?
}

extension Recomendado : Model {
    static var tableName: String = "recomendado"
    static var idColumnName: String = "recomendado_id"
    
    
    public static func findAllRelations(_ completion: @escaping ([RecomendadoClass?], RequestError?)-> Void) {
        
        guard
            let table = try? Recomendado.getTable(),
            let oficioTable = try? Oficio.getTable(),
            let distritoTable = try? Distrito.getTable()
        else {
            return completion([],nil)
        }
        
        var recomendados = [RecomendadoClass]()

        App.pool.getConnection { connection, error in
            guard let connection = connection else {
                print(error?.description ?? "")
                return completion([], nil)
            }
            
            let selectQuery = Select(from: table)
                .join(oficioTable).using(Column.init("oficio_id"))
                .join(distritoTable).using(Column.init("distrito_id"))
            
            connection.execute(query: selectQuery) { selectResult in
                guard let resultSet = selectResult.asResultSet else {
                    print("Error connecting: \(selectResult.asError?.localizedDescription ?? "Unknown Error")")
                    return completion([], nil)
                }
                
                resultSet.forEach() { row, error in
                    guard let data = row else {
                        if let error = error {
                            print("Error getting row: \(error)")
                            return completion([], nil)
                        } else {
                            // All rows have been processed
                            return completion(recomendados,nil)
                        }
                    }
                    resultSet.getColumnTitles(callback: { titles in
                        print(titles)
                    })
                    guard
                        let id = data[2] as? Int32,
                        let telefono = data[3] as? Int32,
                        let direccion = data[5] as? String,
                        let nombres = data[6] as? String,
                        let appellidos = data[7] as? String,
                        let foto = data[8] as? String,
                        let descripcion = data[9] as? String,
                    
                        let oId = data[1] as? Int32,
                        let oCategoryId = data[13] as? Int32,
                        let oName = data[14] as? String,
                        let oDescripcion = data[15] as? String,
                    
                        let dId = data[0] as? Int32,
                        let dName = data[16] as? String
                    else {
                        print("Unable to decode Recomendado")
                        return completion([],nil)
                    }
                    
                    let reco = RecomendadoClass(id: Int(id), nombres: nombres, apellidos: appellidos, telefono: Int(telefono), direccion: direccion, foto: foto, descripcion: descripcion, atributos: [], distrito: nil, oficio: nil)
                    let oficio = Oficio(oficio_id: Int(oId), categoria_id: Int(oCategoryId), nombre: oName, descripcion: oDescripcion)
                    let distrito = Distrito(distrito_id: Int(dId), nombre: dName)
                    reco.setOficio(oficio: oficio)
                    reco.setDistrito(distrito: distrito)
                    
                    recomendados.append(reco)
                    
                    
                }
            }
            
        }
    }
    
}
