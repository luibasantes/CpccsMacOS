//
//  subMenuViewController.swift
//  appCpccs
//
//  Created by Estudiante on 6/9/2017.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class subMenuViewController: UIViewController {
    
    @IBOutlet weak var btnParticipacion: UIButton!
    @IBOutlet weak var btnControlSocial: UIButton!
    @IBOutlet weak var btnTransparencia: UIButton!
    @IBOutlet weak var labelTema: UILabel!
   
    private lazy var participacionController: ParticipacionController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("ParticipacionController") as ParticipacionController
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var controlSocialController: ControlSocialController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("SessionsViewController") as ControlSocialController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showParticipacionCiudadana(){
        let image = UIImage(named: "participacion.png")
        btnParticipacion.setImage(image,forState: .Normal)
        //add(asChildViewController: participacionController)
    }
    
    func showControlSocial(){
        //add(asChildViewController: controlSocialController)
    }
    
    func showTransparencia(){
        
    }
    
    func showNoticias(){
        
    }
    
    func showContacto(){
        
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        //viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Notify Child View Controller
        viewController.didMoveToParentViewController(self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMoveToParentViewController(nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    
    @IBAction func pressParticipacion(sender: UIButton) {
        labelTema.text = " Participacion Ciudadana"
        showParticipacionCiudadana()
    }
    
    @IBAction func pressControlSocial(sender: UIButton) {
        labelTema.text = " Control Social"
        showControlSocial()
    }
    
    @IBAction func pressTransparencia(sender: UIButton) {
        labelTema.text = " Transparencia"
        showTransparencia()
    }
    @IBAction func pressNoticias(sender: UIButton) {
        labelTema.text = " Noticias"
        showNoticias()
    }
    @IBAction func pressContactos(sender: UIButton) {
        labelTema.text = " Contacto"
        showContacto()
    }
}

