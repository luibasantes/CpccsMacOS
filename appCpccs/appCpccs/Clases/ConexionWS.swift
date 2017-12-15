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
        let url = NSURL(string: "http://ejrocafuerte.pythonanywhere.com/\(datoaRecuperar)")
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