//
//  ControlSocialController.swift
//  appCpccs
//
//  Created by Sistemas Operativos on 7/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIkit


class ControlSocialController : UIViewController{
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var saluteButton: UIButton!
    @IBAction func salute(sender: UIButton) {
        headLabel.text = "HELLO FROM CONTROL SOCIAL"
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