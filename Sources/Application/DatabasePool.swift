//
//  File.swift
//  
//
//  Created by Irvin Leon on 7/25/20.
//

import Foundation
import SwiftKueryMySQL
import SwiftKueryORM

func initializeDatabasePool() {
    
    let connectionPoolOptions = ConnectionPoolOptions.init(initialCapacity: 10, maxCapacity: 50)
    let pool = MySQLConnection.createPool(host: "localhost", user: "root", password: "11200039", database: "waranka", port: 3306, characterSet: nil, connectionTimeout: 10000, poolOptions: connectionPoolOptions)
    Database.default = Database(pool)
}
