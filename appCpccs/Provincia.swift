//
//  Provincia.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 7/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
class Provincia {
    var id: Int!
    var nombre: String!
    var ciudades: Array<Ciudad>!
    init(){
        self.ciudades = Array<Ciudad>()
    }
    init(id: String, nombre: String){
        self.id = id.toInt()
        self.nombre = nombre
        self.ciudades = Array<Ciudad>()
    }
    init(id: Int, nombre: String){
        self.id = id
        self.nombre = nombre
         self.ciudades = Array<Ciudad>()
    }
    class func dataProvincias(nsdatos: NSData) -> Array<Provincia>{
        var provinciasEC: [Provincia] = []
        let jsonData : AnyObject! = NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let provincias = jsonData["results"]
        if let provinciasArray = provincias as? NSArray{
            provinciasArray.enumerateObjectsUsingBlock({model, index, stop in
                var id = model["id"] as Int
                var nombre = model["nombre"] as String
                var provincia: Provincia = Provincia(id: id, nombre: nombre)
                provincia.obtenerCiudades()
                provinciasEC.append(provincia)
            });
        }
        return provinciasEC
    }
    func obtenerCiudades(){
        var id : Int = self.id
        var ciudadesProv : Array<Ciudad>  = Array<Ciudad>()
        ConexionWS.getDatos("ciudades/?provincia=\(id)&limit=100"){ result in
            ciudadesProv = Ciudad.dataCiudad(result)
            println("ciudades: \(ciudadesProv.count)")
            self.ciudades = ciudadesProv
        }
    }
}