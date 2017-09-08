//
//  ParticipacionController.swift
//  appCpccs
//
//  Created by Sistemas Operativos on 7/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIkit

class ParticipacionController: UIViewController{

    @IBOutlet weak var saluteButton: UIButton!
    @IBOutlet weak var headLabel: UILabel!
    
    @IBAction func salute(sender: UIButton) {
            headLabel.text = "Hello From\n Participacion View"
    }
    
}