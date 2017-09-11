//
//  FacebookController.swift
//  appCpccs
//
//  Created by Estudiante on 4/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class FacebookController: UIViewController{
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let url = NSURL(string: "https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FParticipaEcuador&tabs=timeline&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=false&appId")
        webView.loadRequest(NSURLRequest(URL: url!))
        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
}