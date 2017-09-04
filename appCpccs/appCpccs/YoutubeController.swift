//
//  YoutubeController.swift
//  appCpccs
//
//  Created by Estudiante on 4/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class YoutubeController: UIViewController{
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://www.youtube.com/user/CPCCSEc/featured")
        webView.loadRequest(NSURLRequest(URL: url!))
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}