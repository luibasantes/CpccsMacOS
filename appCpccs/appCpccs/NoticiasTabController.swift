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
    
    @IBOutlet weak var scrollMaster: UIScrollView!
    var img: Array<String>!
    var maxWidth : CGFloat!
    
    override func  viewDidLoad() {
        self.img = ["bar item.png","sharp bar item.png"]
        var titles = ["Noticion 1","Noticion 2"]
        var delta : CGFloat = 0
        self.maxWidth = 0
        for item in img{
            var view = UIView(frame: CGRect(x: 20 + delta, y: 10, width: 230, height: 200))
            var image = UIImageView(frame: CGRect(x: 0, y: 0, width: 230, height: 150))
            var label = UILabel(frame: CGRect(x: 0, y: 150, width: 230, height: 50))
            label.text = titles[0]
            label.backgroundColor = UIColor.blueColor()
            label.textColor = UIColor.whiteColor()
            image.image = UIImage(named: item)
            view.addSubview(image)
            view.addSubview(label)
            scrollMaster.addSubview(view)
            delta = view.frame.maxX
        }
        
        var left = UIImageView(frame: CGRect(x: 0, y: self.scrollMaster.frame.height/2, width: 30, height: 30))
        left.image = UIImage(named: "left arrow.png")
        var right = UIImageView(frame: CGRect(x: self.view.frame.width-30, y: self.scrollMaster.frame.height/2, width: 30, height: 30))
        right.image = UIImage(named: "right arrow.png")
        
        self.view.addSubview(left)
        self.view.addSubview(right)
        scrollMaster.frame = CGRect(x: scrollMaster.frame.minX, y: scrollMaster.frame.minY, width: self.view.frame.width, height: scrollMaster.frame.height)
        maxWidth = delta
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollMaster.contentSize = CGSize(width:self.maxWidth, height: 355)
        super.viewDidLayoutSubviews()
        
    }
}