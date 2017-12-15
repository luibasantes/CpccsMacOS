//
//  ContenidoControlSocial.swift
//  appCpccs
//
//  Created by jjcrow on 9/18/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation

class ContenidoControlSocial{
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
    
    class func getContenido(data:NSData)-> Array<ContenidoControlSocial>{
        var contenidos: [ContenidoControlSocial] = []
        let jsonData : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        let itemsContenidos = jsonData["results"]
        if let contenidosArray = itemsContenidos as? NSArray{
            contenidosArray.enumerateObjectsUsingBlock({model, index, stop in
                let id = model["id"] as! Int
                let titulo = model["descripcion"] as! String
                let descripcion = model["contenido"] as! String
                let link = model["url_video"] as! String
                var splitTitulo = titulo.componentsSeparatedByString("-")
                let titulo1 = splitTitulo[0]
                let seccion = splitTitulo[1]
                let contenidoCS: ContenidoControlSocial = ContenidoControlSocial(id: id, titulo: titulo1,descripcion:descripcion,link:link)
                if(seccion=="CS"){
                    contenidos.append(contenidoCS)
                }
            });
        }
        return contenidos
    }
    
}