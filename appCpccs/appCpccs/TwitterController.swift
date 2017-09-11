//
//  TwitterController.swift
//  appCpccs
//
//  Created by Estudiante on 4/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class TwitterController: UIViewController{

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://twitter.com/CPCCS")
        webView.loadRequest(NSURLRequest(URL: url!))
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}