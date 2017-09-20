//
//  MarcadorMapa.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 20/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import MapKit

class MarcadorMapa: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init (coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
    
    init(direccion: String, telefono: String, coord: CLLocationCoordinate2D){
        self.title = "Contacto: \(telefono)"
        self.subtitle = "Direccion: \(direccion)"
        self.coordinate = coord
    }
}