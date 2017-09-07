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
    var provinciasEC: Array<String>!
    init(){
        provinciasEC = Array<String>()
    }
    
    init(id: String, nombre: String){
        self.id = id.toInt()
        self.nombre = nombre
    }
    func getDatos(datoaRecuperar:String){
        let url = NSURL(string: "http://ejrocafuerte.pythonanywhere.com/provincias/?limit=100")!
        let session = NSURLSession.sharedSession()
        let loadTask=session.dataTaskWithURL(url) { data, response, error -> Void in
            if error != nil {
                println(error.localizedDescription)
                return
            }else{
                var result:NSData = NSData(data: data)
                self.dataProvincias(result)
            }
            
        }
        loadTask.resume()
    }
    
    func dataProvincias(nsdatos: NSData){
        var provinciasEC: [String] = []
        let jsonData : AnyObject! = NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let provincias = jsonData["results"]
        if let provinciasArray = provincias as? NSArray{
            provinciasArray.enumerateObjectsUsingBlock({model, index, stop in
                let provincia=model["nombre"] as String
                println(provincia)
                self.provinciasEC.append(provincia)
            });
        }
    }
}