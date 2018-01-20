//
//  subMenuViewController.swift
//  appCpccs
//
//  Created by Estudiante on 6/9/2017.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class subMenuViewController: UIViewController {
    
    @IBOutlet weak var btnContacto: UIButton!
    @IBOutlet weak var btnNoticias: UIButton!
    @IBOutlet weak var btnParticipacion: UIButton!
    @IBOutlet weak var btnControlSocial: UIButton!
    @IBOutlet weak var btnTransparencia: UIButton!
    @IBOutlet weak var labelTema: UILabel!
    @IBOutlet weak var contenedor: UIView!
    var comeFrom: String!
    
    private lazy var participacionController: ParticipacionController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("ParticipacionController") as! ParticipacionController
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var controlSocialController: ControlSocialController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("ControlSocialController")as! ControlSocialController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()

    private lazy var transparenciaController: TransparenciaController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("TransparenciaController") as! TransparenciaController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var noticiasController: NoticiasTabController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("NoticiasTabController") as! NoticiasTabController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var contactoController: ContactoController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("ContactoController") as! ContactoController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        if(comeFrom != nil){
            
            if(comeFrom == "PC"){
                labelTema.text = "Participacion Ciudadana"
                if(NetworkReachabilityManager()!.isReachable){
                    print("EL INTERNET ESTA DISPONIBLE!!!!!")
                    showParticipacionCiudadana()
                }
                else{
                    let alertController = UIAlertController(title: "Solicitud Fallida", message: "No tiene conexion a internet!", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                        print("OK button tapped")
                    })
                    alertController.addAction(okAction)
                    presentViewController(alertController, animated: true, completion: nil)
                }
            }
            else if(comeFrom == "CS"){
                labelTema.text = "Control Social"
                if(NetworkReachabilityManager()!.isReachable){
                    print("EL INTERNET ESTA DISPONIBLE!!!!!")
                    showControlSocial()
                }
                else{
                    let alertController = UIAlertController(title: "Solicitud Fallida", message: "No tiene conexion a internet!", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                        print("OK button tapped")
                    })
                    alertController.addAction(okAction)
                    presentViewController(alertController, animated: true, completion: nil)
                }
            }
            else if(comeFrom == "TP"){
                labelTema.text = "Transparencia"
                if(NetworkReachabilityManager()!.isReachable){
                    print("EL INTERNET ESTA DISPONIBLE!!!!!")
                    showTransparencia()
                }
                else{
                    let alertController = UIAlertController(title: "Solicitud Fallida", message: "No tiene conexion a internet!", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                        print("OK button tapped")
                    })
                    alertController.addAction(okAction)
                    presentViewController(alertController, animated: true, completion: nil)
                }
            }
            else if(comeFrom == "NOTICIAS"){
                labelTema.text = "Noticias"
                if(NetworkReachabilityManager()!.isReachable){
                    print("EL INTERNET ESTA DISPONIBLE!!!!!")
                    showNoticias()
                }
                else{
                    let alertController = UIAlertController(title: "Solicitud Fallida", message: "No tiene conexion a internet!", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                        print("OK button tapped")
                    })
                    alertController.addAction(okAction)
                    presentViewController(alertController, animated: true, completion: nil)
                }
            }
            else if(comeFrom == "CONTACTO"){
                labelTema.text = "Contacto"
                showContacto()
            }
            comeFrom = ""
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showParticipacionCiudadana(){
        let imageParticipacion = UIImage(named: "particpacion.png")
        btnParticipacion.setImage(imageParticipacion,forState: .Normal)
        let imageControl = UIImage(named: "controlSocialGris.png")
        btnControlSocial.setImage(imageControl,forState: .Normal)
        let imageTransparencia = UIImage(named: "transparenciaGris.png")
        btnTransparencia.setImage(imageTransparencia,forState: .Normal)
        btnNoticias.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnContacto.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        add(asChildViewController: participacionController)
    }
    
    func showControlSocial(){
        let imageParticipacion = UIImage(named: "participacionGris.png")
        btnParticipacion.setImage(imageParticipacion,forState: .Normal)
        let imageControl = UIImage(named: "controlSocial.png")
        btnControlSocial.setImage(imageControl,forState: .Normal)
        let imageTransparencia = UIImage(named: "transparenciaGris.png")
        btnTransparencia.setImage(imageTransparencia,forState: .Normal)
        btnNoticias.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnContacto.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        add(asChildViewController: controlSocialController)
    }
    
    func showTransparencia(){
        let imageParticipacion = UIImage(named: "participacionGris.png")
        btnParticipacion.setImage(imageParticipacion,forState: .Normal)
        let imageControl = UIImage(named: "controlSocialGris.png")
        btnControlSocial.setImage(imageControl,forState: .Normal)
        let imageTransparencia = UIImage(named: "transparencia.png")
        btnTransparencia.setImage(imageTransparencia,forState: .Normal)
        btnNoticias.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnContacto.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        add(asChildViewController: transparenciaController)
    }
    
    func showNoticias(){
        let imageParticipacion = UIImage(named: "participacionGris.png")
        btnParticipacion.setImage(imageParticipacion,forState: .Normal)
        let imageControl = UIImage(named: "controlSocialGris.png")
        btnControlSocial.setImage(imageControl,forState: .Normal)
        let imageTransparencia = UIImage(named: "transparenciaGris.png")
        btnTransparencia.setImage(imageTransparencia,forState: .Normal)
        btnNoticias.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnContacto.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        add(asChildViewController: noticiasController)
    }
    
    func showContacto(){
        let imageParticipacion = UIImage(named: "participacionGris.png")
        btnParticipacion.setImage(imageParticipacion,forState: .Normal)
        let imageControl = UIImage(named: "controlSocialGris.png")
        btnControlSocial.setImage(imageControl,forState: .Normal)
        let imageTransparencia = UIImage(named: "transparenciaGris.png")
        btnTransparencia.setImage(imageTransparencia,forState: .Normal)
        btnContacto.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnNoticias.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        add(asChildViewController: contactoController)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        contenedor.addSubview(viewController.view)
        addChildViewController(viewController)
        
        // Add Child View as Subview
        //view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = contenedor.bounds
        //viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Notify Child View Controller
        //viewController.didMoveToParentViewController()
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
        if(NetworkReachabilityManager()!.isReachable){
            print("EL INTERNET ESTA DISPONIBLE!!!!!")
            showParticipacionCiudadana()
        }
        else{
            let alertController = UIAlertController(title: "Solicitud Fallida", message: "No tiene conexion a internet!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                print("OK button tapped")
            })
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func pressControlSocial(sender: UIButton) {
        labelTema.text = " Control Social"
        if(NetworkReachabilityManager()!.isReachable){
            print("EL INTERNET ESTA DISPONIBLE!!!!!")
            showControlSocial()
        }
        else{
            let alertController = UIAlertController(title: "Solicitud Fallida", message: "No tiene conexion a internet!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                print("OK button tapped")
            })
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressTransparencia(sender: UIButton) {
        labelTema.text = " Transparencia"
        if(NetworkReachabilityManager()!.isReachable){
            print("EL INTERNET ESTA DISPONIBLE!!!!!")
            showTransparencia()
        }
        else{
            let alertController = UIAlertController(title: "Solicitud Fallida", message: "No tiene conexion a internet!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                print("OK button tapped")
            })
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressNoticias(sender: UIButton) {
        labelTema.text = " Noticias"
        if(NetworkReachabilityManager()!.isReachable){
            print("EL INTERNET ESTA DISPONIBLE!!!!!")
            showNoticias()
        }
        else{
            let alertController = UIAlertController(title: "Solicitud Fallida", message: "No tiene conexion a internet!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                print("OK button tapped")
            })
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressContactos(sender: UIButton) {
        labelTema.text = " Contacto"
        showContacto()
    }
}

