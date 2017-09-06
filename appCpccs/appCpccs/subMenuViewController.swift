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
    }
    
    func showControlSocial(){
        
    }
    
    func showTransparencia(){
        
    }
    
    func showNoticias(){
        
    }
    
    func showContacto(){
        
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

