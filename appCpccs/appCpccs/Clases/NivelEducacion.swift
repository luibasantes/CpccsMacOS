//
//  NivelEducacion.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 8/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
class NivelEducacion{
    var id: Int!
    var nombre: String!
    var descripcion: String!
    init(){
        
    }
    init(id: Int, nombre: String, descripcion: String){
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
    }
    class func dataNivelEduc(nsdatos: NSData) -> Array<NivelEducacion>{
        var result: [NivelEducacion] = []
        let jsonData : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers)
        if(jsonData != nil){
            let niveles = jsonData["results"]
            if let nivelesArray = niveles as? NSArray{
                nivelesArray.enumerateObjectsUsingBlock({model, index, stop in
                    let id = model["id"] as! Int
                    let nombre = model["nombre"] as! String
                    let desc = model["descripcion"] as! String
                    let nivelesEduc: NivelEducacion = NivelEducacion(id: id, nombre: nombre, descripcion: desc)
                    result.append(nivelesEduc)
                });
            }
            return result
        }
        else{
            return result
        }
    }
    class func buscarNEducId(niveles: Array<NivelEducacion>,nivelBuscar: String) -> Int{
        for var i=0; i<niveles.count; i++ {
            if(niveles[i].nombre == nivelBuscar) {
                return niveles[i].id
            }
        }
        return -1
    }
}