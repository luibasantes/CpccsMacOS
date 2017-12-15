//
//  Genero.swift
//  appCpccs
//
//  Created by Sistemas Operativos on 13/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
class Genero{
    var id: Int!
    var nombre: String!
    init(){
        
    }
    init(id: Int, nombre: String){
        self.id = id
        self.nombre = nombre
    }
    class func dataGenero(nsdatos: NSData) -> Array<Genero>{
        var result: [Genero] = []
        let jsonData : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers)
        let generos = jsonData["results"]
        if let generosArray = generos as? NSArray{
            generosArray.enumerateObjectsUsingBlock({model, index, stop in
                let id = model["id"] as! Int
                let nombre = model["nombre"] as! String
                let generos: Genero = Genero(id: id, nombre: nombre)
                result.append(generos)
            });
        }
        return result
    }
    class func buscarGeneroId(generos: Array<Genero>,generoBuscar: String) -> Int{
        for var i=0; i<generos.count; i++ {
            if(generos[i].nombre == generoBuscar) {
                return generos[i].id
            }
        }
        return -1
    }
}