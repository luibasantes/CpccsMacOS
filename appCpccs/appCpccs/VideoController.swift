//
//  VideoController.swift
//  appCpccs
//
//  Created by jjcrow on 9/21/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIkit

class VideoController : UIViewController{
    
    var link : String!
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad(){
        let url = NSURL(string: link)
        webView.loadRequest(NSURLRequest(URL: url!))
        print("Link:  \(link)")
        super.viewDidLoad()
    }
    
}