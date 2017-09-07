//
//  DenunciasController.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 7/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class DenunciasController: UIViewController{
    @IBOutlet weak var txtProvincias: UITextView!
    
    
    @IBAction func cargarProv(sender: UIButton) {
        var conn = ConexionWS()
        var provinciasEC = Provincia()
        provinciasEC.getDatos("provincias")
        println(provinciasEC.provinciasEC)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}