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
    
    @IBOutlet weak var contentView1: UIView!
    @IBOutlet weak var contentView2: UIView!
    @IBOutlet weak var textView1: UITextView!
    var view2Dimension = CGRect()
    
    @IBOutlet weak var view2Height: NSLayoutConstraint!
    @IBOutlet weak var view1Height: NSLayoutConstraint!
    @IBAction func showContent1(sender: UIButton) {
    }
    override func viewDidLoad() {
        view1Height.constant=0
        view2Height.constant=0
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}