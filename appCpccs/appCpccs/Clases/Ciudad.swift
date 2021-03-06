//
//  Ciudad.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 8/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
class Ciudad {
    var id: Int!
    var nombre: String!
    var provincia: Int!
    init(){
    }
    init(id: Int, nombre: String, provincia: Int){
        self.id = id
        self.nombre = nombre
    }
    class func dataCiudad(nsdatos: NSData) -> Array<Ciudad>{
        var ciudadesEC: [Ciudad] = []
        let jsonData : AnyObject! = NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let ciudades = jsonData["results"]
        if let ciudadesArray = ciudades as? NSArray{
            ciudadesArray.enumerateObjectsUsingBlock({model, index, stop in
                var id = model["id"] as Int
                var nombre = model["nombre"] as String
                var prov = model["provincia"] as Int
                var ciudad: Ciudad = Ciudad(id: id, nombre: nombre, provincia: prov)
                ciudadesEC.append(ciudad)
            });
        }
        return ciudadesEC
    }
    class func buscarCiudadId(ciudades: Array<Ciudad>,ciudadBuscar: String) -> Int{
        for var i=0; i<ciudades.count; i++ {
            if ciudades[i].nombre == ciudadBuscar {
                return ciudades[i].id
            }
        }
        return -1
    }
}