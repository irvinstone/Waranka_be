//
//  File.swift
//  
//
//  Created by Irvin Leon on 7/25/20.
//

import Kitura

func initializeApiRoutes(app: App) {
    
    app.router.get("/oficio", handler: OficioController.findAllHandler)
    app.router.post("/oficio", handler: OficioController.createHandler)
    
    app.router.get("/distritos", handler: DistritoController.findAllHandler)
    app.router.get("/distritos/predict", handler: DistritoController.filterHandler)
    
    app.router.get("/users", handler: UserController.findAllHandler)
    app.router.post("/user", handler: UserController.createHandler)
    app.router.get("/user/:id", handler: UserController.findHandler)
    
    app.router.post("/recomendado", handler: RecomendadoController.createHandler)
    app.router.get("/recomendados", handler: RecomendadoController.findAllHandler)
    app.router.get("/recomendado/:id", handler: RecomendadoController.findHandler)
    
    app.router.post("/atributo", handler: AtributoController.createHandler)



    app.router.post("/user/profile") { (request: RouterRequest, response, next) in
        let data = try? request.readString()
        response.send(data)
        
        next()
    }

}
