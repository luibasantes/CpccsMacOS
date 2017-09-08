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
        let jsonData : AnyObject! = NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let etnias = jsonData["results"]
        if let etniasArray = etnias as? NSArray{
            etniasArray.enumerateObjectsUsingBlock({model, index, stop in
                var id = model["id"] as Int
                var nombre = model["nombre"] as String
                var etnias: Etnia = Etnia(id: id, nombre: nombre)
                etniasEC.append(etnias)
            });
        }
        return etniasEC
    }
}