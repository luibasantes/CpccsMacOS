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
    
    @IBOutlet weak var pcButton: UIButton!
    @IBOutlet weak var csButton: UIButton!
    @IBOutlet weak var tpButton: UIButton!
    @IBOutlet weak var noticiasButton: UIButton!
    @IBOutlet weak var contactoButton: UIButton!
    var section: String!
    
    func goToSubMenu(sender: UIButton){
        if(sender == pcButton){
            section = "PC"
        }
        else if(sender == csButton){
            section = "CS"
        }
        else if(sender == tpButton){
            section = "TP"
        }
        else if(sender == noticiasButton){
            section = "NOTICIAS"
        }
        else if(sender == contactoButton){
            section = "CONTACTO"
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateViewControllerWithIdentifier("subMenuViewController") as! subMenuViewController
        viewController.comeFrom = self.section
        self.presentViewController(viewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuControl = false
        pcButton.addTarget(self, action: "goToSubMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        csButton.addTarget(self, action: "goToSubMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        tpButton.addTarget(self, action: "goToSubMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        noticiasButton.addTarget(self, action: "goToSubMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        contactoButton.addTarget(self, action: "goToSubMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func toolBar(sender: AnyObject) {
      print("hola")
        if(menuControl){
            leadingToolBar.constant = -200
        }else{
            leadingToolBar.constant = -16
            UIView.animateWithDuration(0.5, animations: {self.view.layoutIfNeeded()})
        }
        menuControl = !menuControl
        
    }
}