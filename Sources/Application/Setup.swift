//
//  File.swift
//  
//
//  Created by Irvin Leon on 9/7/20.
//

import KituraCORS


func enablingCors(app: App) {
    let options = Options(allowedOrigin: .all)
    let cors = CORS(options: options)
    app.router.all(middleware: cors)
}
