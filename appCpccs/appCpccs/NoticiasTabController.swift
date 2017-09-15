//
//  NoticiasTabController.swift
//  appCpccs
//
//  Created by Sistemas Operativos on 8/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIkit

class NoticiasTabController : UIViewController{

    @IBOutlet weak var headLabel: UILabel!

    @IBAction func salute(sender: UIButton) {
        headLabel.text = "Hello From \n NOTICIAS view"
    }
}