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
    var latitud: Float!
    var longuitud: Float!
    var telefono: String!
    var ciudad: String!
    var direccion: String!
    var twitter: String!
    init(){
        
    }
    init(nombre: String!, latitud: String!, longuitud: String!, telefono: String!, ciudad: String!, direccion: String!, twitter: String!){
        self.nombre=nombre
        self.latitud=(latitud as NSString).floatValue
        self.longuitud=(longuitud as NSString).floatValue
        self.telefono = telefono
        self.ciudad = ciudad
        self.direccion = direccion
        self.twitter = twitter
    }
    
    
}