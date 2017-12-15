//
//  DenunciaController.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 18/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit
class EvidenciaController: UIViewController{
    var datos: Denuncia!
    
    @IBOutlet weak var txtDescripcion: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnADenunciado(sender: UIButton) {
            if txtDescripcion.text.isEmpty{
                let alertController = UIAlertController(title: "Error", message: "Debe completar los campos para pasar a la siguiente parte de su denuncia", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction) in
                    print("you have pressed Yes button");
                    //Call another alert here
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion:nil)
            }
            else{
                self.datos.descripcion_denuncia = txtDescripcion.text
            }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destino = segue.destinationViewController as? DenunciadoController {
            destino.datosDenuncia = self.datos
        } else if let destino = segue.destinationViewController as? DenunciasController {
            destino.datosDenuncia = self.datos
        }else if let destino = segue.destinationViewController as? PeticionarioController {
            destino.datosDenuncia = self.datos
        } else if let destino = segue.destinationViewController as? PedidoController {
            destino.datosDenuncia = self.datos
        }
    }
}