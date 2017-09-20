//
//  CpccsTVController.swift
//  appCpccs
//
//  Created by jjcrow on 9/20/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIkit

class CpccsTVController : UIViewController{
    
    @IBOutlet weak var webView: UIWebView!
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        let url = NSURL(string: "https://livestream.com/accounts/1785250/events/2708656/player?width=560&height=315&autoPlay=true&mute=false")
        webView.loadRequest(NSURLRequest(URL: url!))
        
        super.viewDidLoad()
        
    }
}