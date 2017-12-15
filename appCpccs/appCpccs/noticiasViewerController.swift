//
//  noticiasViewerController.swift
//  appCpccs
//
//  Created by jjcrow on 11/1/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class noticiasViewerController : UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var link : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: link)
        webView.loadRequest(NSURLRequest(URL: url!))
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}
