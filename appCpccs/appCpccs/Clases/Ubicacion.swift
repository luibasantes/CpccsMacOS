//
//  Ubicacion.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 20/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation

class Ubicacion{
    var nombre: String!
    var latitud: Double!
    var longitud: Double!
    var telefono: String!
    var ciudad: String!
    var direccion: String!
    var twitter: String!
    init(){
        
    }
    init(nombre: String!, latitud: String!, longitud: String!, telefono: String!, ciudad: String!, direccion: String!, twitter: String!){
        self.nombre=nombre
        self.latitud=(latitud as NSString).doubleValue
        self.longitud=(longitud as NSString).doubleValue
        self.telefono = telefono
        self.ciudad = ciudad
        self.direccion = direccion
        self.twitter = twitter
    }
    init(nombre: String!, latitud: Double!, longitud: Double!, telefono: String!, ciudad: String!, direccion: String!, twitter: String!){
        self.nombre=nombre
        self.latitud=latitud
        self.longitud=longitud
        self.telefono = telefono
        self.ciudad = ciudad
        self.direccion = direccion
        self.twitter = twitter
    }
    class func dataUbicaciones(nsdatos: NSData) -> Array<Ubicacion>{
        var agenciasEC: [Ubicacion] = []
        let jsonData : AnyObject! = NSJSONSerialization.JSONObjectWithData(nsdatos, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let provincias: AnyObject! = jsonData["oficinas"]
        if NSJSONSerialization.isValidJSONObject(jsonData) {
            //let provincias: AnyObject! = NSJSONSerialization.valueForKey("oficinas")
            //print(provincias)
            
            if var provinciasArray = provincias as? NSObject{
                //print(provinciasArray.objectAtIndex(0) as? NSArray)
                let x: NSObject! = provinciasArray.valueForKeyPath("provincia") as? NSObject
                let agencias = x as NSArray
                print(agencias.count)
                for var i = 0; i < agencias.count; i++ {
                    var nombre = (agencias.objectAtIndex(i) as NSDictionary).objectForKey("nombre") as String
                    var latitud = (agencias.objectAtIndex(i) as NSDictionary).objectForKey("latitud") as String
                    var longitud = (agencias.objectAtIndex(i) as NSDictionary).objectForKey("longitud") as String
                    var telefono = (agencias.objectAtIndex(i) as NSDictionary).objectForKey("telefono") as String
                    var ciudad = (agencias.objectAtIndex(i) as NSDictionary).objectForKey("ciudad") as String
                    var direccion = (agencias.objectAtIndex(i) as NSDictionary).objectForKey("direccion") as String
                    var twitter = (agencias.objectAtIndex(i) as NSDictionary).objectForKey("twitter") as String
                    var ubicacion: Ubicacion = Ubicacion(nombre: nombre, latitud: latitud, longitud: longitud, telefono:telefono, ciudad: ciudad, direccion: direccion, twitter: twitter)
                    agenciasEC.append(ubicacion)
                    print(ubicacion)

                }
            }
        }
        return agenciasEC
    }
}