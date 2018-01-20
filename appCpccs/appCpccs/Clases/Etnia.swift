//
//  Etnia.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 8/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
class Etnia{
    var id: Int!
    var nombre: String!
    init(){
        
    }
    init(id: Int, nombre: String){
        self.id = id
        self.nombre = nombre
    }
    class func dataEtnia(nsdatos: NSData) -> Array<Etnia>{
        var etniasEC: [Etnia] = []
        let jsonData : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers)
        if(jsonData != nil){
            let etnias = jsonData["results"]
        
            if let etniasArray = etnias as? NSArray{
                etniasArray.enumerateObjectsUsingBlock({model, index, stop in
                    let id = model["id"] as! Int
                    let nombre = model["nombre"] as! String
                    let etnias: Etnia = Etnia(id: id, nombre: nombre)
                    etniasEC.append(etnias)
                });
            }
            return etniasEC
        }
        else{
            return etniasEC
        }
    }
    class func buscarEtniaId(etnias: Array<Etnia>,etniaBuscar: String) -> Int{
        for var i=0; i<etnias.count; i++ {
            if(etnias[i].nombre == etniaBuscar) {
                return etnias[i].id
            }
        }
        return -1
    }
}