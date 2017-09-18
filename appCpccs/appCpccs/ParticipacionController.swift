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
    
    
    @IBOutlet weak var text1Height: NSLayoutConstraint!
    @IBOutlet weak var view1Height: NSLayoutConstraint!
    @IBOutlet weak var view2Height: NSLayoutConstraint!
    @IBOutlet weak var text2Height: NSLayoutConstraint!
    @IBOutlet weak var view3Height: NSLayoutConstraint!
    @IBOutlet weak var text3Height: NSLayoutConstraint!
    @IBOutlet weak var view4Height: NSLayoutConstraint!
    @IBOutlet weak var text4Height: NSLayoutConstraint!
    @IBOutlet weak var view5Height: NSLayoutConstraint!
    @IBOutlet weak var text5Height: NSLayoutConstraint!
    @IBOutlet weak var view6Height: NSLayoutConstraint!
    @IBOutlet weak var text6Height: NSLayoutConstraint!
    @IBOutlet weak var view7height: NSLayoutConstraint!
    @IBOutlet weak var text7Height: NSLayoutConstraint!
    
    
    
    var v1HeightContainer = NSLayoutConstraint()
    var v2HeightContainer = NSLayoutConstraint()
    var v3HeightContainer = NSLayoutConstraint()
    var v4HeightContainer = NSLayoutConstraint()
    var v5HeightContainer = NSLayoutConstraint()
    var v6HeightContainer = NSLayoutConstraint()
    var v7HeightContainer = NSLayoutConstraint()
    
    var txt1HeightContainer = NSLayoutConstraint()
    var txt2HeightContainer = NSLayoutConstraint()
    var txt3HeightContainer = NSLayoutConstraint()
    var txt4HeightContainer = NSLayoutConstraint()
    var txt5HeightContainer = NSLayoutConstraint()
    var txt6HeightContainer = NSLayoutConstraint()
    var txt7HeightContainer = NSLayoutConstraint()
    
    @IBAction func showView1(sender: UIButton) {
        if(view1Height.constant != v1HeightContainer.constant){
        view1Height.constant = v1HeightContainer.constant
        text1Height.constant = txt1HeightContainer.constant
        }
        else{
            view1Height.constant = 0
            text1Height.constant = 0
        }
    }
    
    @IBAction func showView2(sender: UIButton) {
        if(view2Height.constant != v2HeightContainer.constant){
            view2Height.constant = v2HeightContainer.constant
            text2Height.constant = txt2HeightContainer.constant
        }
        else{
            view2Height.constant = 0
            text2Height.constant = 0
        }
    }
    
    @IBAction func showView3(sender: UIButton) {
        if(view3Height.constant != v3HeightContainer.constant){
            view3Height.constant = v3HeightContainer.constant
            text3Height.constant = txt3HeightContainer.constant
        }
        else{
            view3Height.constant = 0
            text3Height.constant = 0
        }
    }
    
    @IBAction func showView4(sender: UIButton) {
        if(view4Height.constant != v4HeightContainer.constant){
            view4Height.constant = v4HeightContainer.constant
            text4Height.constant = txt4HeightContainer.constant
        }
        else{
            view4Height.constant = 0
            text4Height.constant = 0
        }
    }
    
    @IBAction func showView5(sender: UIButton) {
        if(view5Height.constant != v5HeightContainer.constant){
            view5Height.constant = v5HeightContainer.constant
            text5Height.constant = txt5HeightContainer.constant
        }
        else{
            view5Height.constant = 0
            text5Height.constant = 0
        }
    }
    
    @IBAction func showView6(sender: UIButton) {
        if(view6Height.constant != v6HeightContainer.constant){
            view6Height.constant = v6HeightContainer.constant
            text6Height.constant = txt6HeightContainer.constant
        }
        else{
            view6Height.constant = 0
            text6Height.constant = 0
        }
    }
    
    @IBAction func showView7(sender: UIButton) {
        if(view7height.constant != v7HeightContainer.constant){
            view7height.constant = v7HeightContainer.constant
            text7Height.constant = txt7HeightContainer.constant
        }
        else{
            view7height.constant = 0
            text7Height.constant = 0
        }
    }
    
    
    
    override func viewDidLoad() {
        v1HeightContainer.constant = view1Height.constant
        v2HeightContainer.constant = view2Height.constant
        v3HeightContainer.constant = view3Height.constant
        v4HeightContainer.constant = view4Height.constant
        v5HeightContainer.constant = view5Height.constant
        v6HeightContainer.constant = view6Height.constant
        v7HeightContainer.constant = view7height.constant
        
        txt1HeightContainer.constant = text1Height.constant
        txt2HeightContainer.constant = text2Height.constant
        txt3HeightContainer.constant = text3Height.constant
        txt4HeightContainer.constant = text4Height.constant
        txt5HeightContainer.constant = text5Height.constant
        txt6HeightContainer.constant = text6Height.constant
        txt7HeightContainer.constant = text7Height.constant
        
        view1Height.constant = 0
        text1Height.constant = 0
        view2Height.constant = 0
        text2Height.constant = 0
        view3Height.constant = 0
        text3Height.constant = 0
        view4Height.constant = 0
        text4Height.constant = 0
        view5Height.constant = 0
        text5Height.constant = 0
        view6Height.constant = 0
        text6Height.constant = 0
        view7height.constant = 0
        text7Height.constant = 0
        
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}