//
//  menuViewController.swift
//  appCpccs
//
//  Created by Estudiante on 6/9/2017.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class menuViewController: UIViewController {
    
    @IBOutlet weak var leadingToolBar: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    var menuControl = false
    override func viewDidLoad() {
        super.viewDidLoad()
        menuControl = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func toolBar(sender: AnyObject) {
      println("hola")
        if(menuControl){
            leadingToolBar.constant = -200
        }else{
            leadingToolBar.constant = -16
            UIView.animateWithDuration(0.5, animations: {self.view.layoutIfNeeded()})
        }
        menuControl = !menuControl
        
    }
}