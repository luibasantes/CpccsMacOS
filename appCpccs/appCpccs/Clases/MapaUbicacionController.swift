//
//  MapaUbicacion.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 20/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIkit
import MapKit
class MapaUbicacionController: UIViewController {
    
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var txtUbicacion: UITextField!
    var ubicaciones: Array<Ubicacion>!
    
    override func viewDidLoad() {
        MapaUbicacionController.cargaUbicaciones(){ result in
            let jsonData : AnyObject! = NSJSONSerialization.JSONObjectWithData(result, options: NSJSONReadingOptions.MutableContainers, error: nil)
            let provincias = jsonData["provincia"]
            if let provinciasArray = provincias as? NSArray{
                provinciasArray.enumerateObjectsUsingBlock({model, index, stop in
                    var id = model["id"] as Int
                    var nombre = model["nombre"] as String
                    var provincia: Provincia = Provincia(id: id, nombre: nombre)
                });
            }

            //self.ubicaciones =
            
        }
    }
    class func cargaUbicaciones(completion:(NSData)->Void) -> Void {
        let url = NSURL(string: "http://denunciaec.co.nf/oficinas.json")
        let session = NSURLSession.sharedSession()
        let loadTask=session.dataTaskWithURL(url!) { (data, response, error) in
            if error != nil {
                println(error.localizedDescription)
                return
            }
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            if result != nil {
                completion(data)
            }
            }.resume()
    }
}