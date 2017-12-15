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
        let jsonData : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers)
        let estadosciviles = jsonData["results"]
        if let estadoscivilesArray = estadosciviles as? NSArray{
            estadoscivilesArray.enumerateObjectsUsingBlock({model, index, stop in
                let id = model["id"] as! Int
                let nombre = model["nombre"] as! String
                let estadocivil: EstadoCivil = EstadoCivil(id: id, nombre: nombre)
                estadoC.append(estadocivil)
            });
        }
        return estadoC
    }
    class func buscarEstadoCId(estadosC: Array<EstadoCivil>,estadoC: String) -> Int{
        for var i=0; i<estadosC.count; i++ {
            if(estadosC[i].nombre == estadoC) {
                return estadosC[i].id
            }
        }
        return -1
    }
}