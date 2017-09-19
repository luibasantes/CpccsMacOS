//
//  ContenidoTransparencia.swift
//  appCpccs
//
//  Created by jjcrow on 9/18/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation

class ContenidoTransparencia{
    var id: Int!
    var titulo: String!
    var descripcion: String!
    var link: String!
    
    init(){
    }
    
    init(id: Int,titulo: String, descripcion: String, link: String){
        self.id = id
        self.titulo = titulo
        self.descripcion = descripcion
        self.link = link
    }
    
    class func getContenido(data:NSData)-> Array<ContenidoTransparencia>{
        var contenidos: [ContenidoTransparencia] = []
        let jsonData : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let itemsContenidos = jsonData["results"]
        if let contenidosArray = itemsContenidos as? NSArray{
            contenidosArray.enumerateObjectsUsingBlock({model, index, stop in
                var id = model["id"] as Int
                var titulo = model["descripcion"] as String
                var descripcion = model["contenido"] as String
                var link = model["url_video"] as String
                var splitTitulo = split(titulo){$0 == "-"}
                var titulo1 = splitTitulo[0]
                var seccion = splitTitulo[1]
                var contenidoTP: ContenidoTransparencia = ContenidoTransparencia(id: id, titulo: titulo1,descripcion:descripcion,link:link)
                if(seccion=="TP"){
                    contenidos.append(contenidoTP)
                }
            });
        }
        return contenidos
    }
    
}