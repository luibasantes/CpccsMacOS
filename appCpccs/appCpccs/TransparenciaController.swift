//
//  TransparenciaController.swift
//  appCpccs
//
//  Created by Sistemas Operativos on 8/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIkit

class TransparenciaController : UIViewController{
    
    
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBAction func saludar(sender: UIButton) {
        headingLabel.text = "Hello from \n Transparencia View"
    }
}