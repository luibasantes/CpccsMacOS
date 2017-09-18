//
//  Denuncia.swift
//  appCpccs
//
//  Created by Sistemas Operativos on 13/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
class Denuncia{
    //datos del denunciante
    var identidad_reservada: Bool!
    var nombres_apellidos_denunciante: String!
    var edad_denunciante: Int!
    var correo_denunciante: String!
    var telefono: String!
    var celular: String!
    var direccion: String!
    var ciudad_denunciante_id: Int!
    var provincia_denunciante_id: Int!
    var genero_denunciante: String!
    var etnia: Int!
    var nivel_educacion_id: Int!
    var institucion_denunciante: String!
    var cargo_denunciante: String!
    var tipo_identificacion: String!
    var no_identificacion: String!
    var pais: String!
    //datos del denunciado
    var nombres_apellidos_denunciado: String!
    var genero_denunciado: String!
    var institucion_denunciado: String!
    var cargo_denunciado: String!
    var provincia_denunciado_id: Int!
    var ciudad_denunciado_id: Int!
    var parroquia_denunciado: String!
    //informacion de denuncia
    var descripcion_denuncia: String!
    init(){
        
    }
}