//
//  ConexionWS.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 7/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
class ConexionWS {
    var datos = NSData()
    
    init(){
        
    }
    class func getDatos(datoaRecuperar:String, completion:(NSData)->Void) -> Void {
        let url = NSURL(string: "http://190.152.149.89:8181/\(datoaRecuperar)")
        let session = NSURLSession.sharedSession()
        session.configuration.timeoutIntervalForRequest = 10.0
        session.configuration.timeoutIntervalForResource = 10.0
        session.dataTaskWithURL(url!) { (data, response, error) in
            //let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            if data != nil {
                print("PETICION GET A WEB SERVICE HA SIDO PROCESADA!!!")
                completion(data!)
            }
            else{
                completion("ERROR".dataUsingEncoding(NSUTF8StringEncoding)!)
            }
            
        }.resume()
    }
    class func getUbicaciones(completion:(NSData)->Void) -> Void {
        let url = NSURL(string: "http://denunciaec.co.nf/oficinas.json")
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            if result != nil {
                completion(data!)
            }
            }.resume()
    }
}