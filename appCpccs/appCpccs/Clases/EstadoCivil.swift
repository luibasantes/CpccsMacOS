//
//  EstadoCivil.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 8/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
class EstadoCivil{
    var id: Int!
    var nombre: String!
    init(){
        
    }
    init(id: Int, nombre: String){
        self.id = id
        self.nombre = nombre
    }
    class func dataEstadoC(nsdatos: NSData) -> Array<EstadoCivil>{
        var estadoC: [EstadoCivil] = []
        let jsonData : AnyObject! = NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let estadosciviles = jsonData["results"]
        if let estadoscivilesArray = estadosciviles as? NSArray{
            estadoscivilesArray.enumerateObjectsUsingBlock({model, index, stop in
                var id = model["id"] as Int
                var nombre = model["nombre"] as String
                var estadocivil: EstadoCivil = EstadoCivil(id: id, nombre: nombre)
                estadoC.append(estadocivil)
            });
        }
        return estadoC
    }∂
}