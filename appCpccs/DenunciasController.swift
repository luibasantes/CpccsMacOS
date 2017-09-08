//
//  DenunciasController.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 7/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class DenunciasController: UIViewController{
    @IBOutlet weak var txtProvincias: UITextView!
    var provinciasEC: Array<Provincia>!
    var ciudadesEC: Array<Ciudad>!
    var etniasEC: Array<Etnia>!
    var estadosC: Array<EstadoCivil>!
    var nivelesEduc: Array<NivelEducacion>!
    
    @IBOutlet weak var txtEstadoCivil: UITextField!
    var autocompleteCharacterCount = 0
    
    @IBAction func cargarProv(sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ConexionWS.getDatos("provincias/?limit=100"){ result in
            self.provinciasEC = Provincia.dataProvincias(result)
            println("Provincias: \(self.provinciasEC.count)")
        }
        ConexionWS.getDatos("ciudades/?\(1)&limit=100"){ result in
            self.ciudadesEC = Ciudad.dataCiudad(result)
            println("ciudades: \(self.ciudadesEC.count)")
        }
        ConexionWS.getDatos("etnias/?limit=10"){ result in
            self.etniasEC = Etnia.dataEtnia(result)
            println("etnias \(self.etniasEC.count)")
        }
        ConexionWS.getDatos("estados-civiles/?limit=10"){ result in
            self.estadosC = EstadoCivil.dataEstadoC(result)
            println("estado civil: \(self.estadosC.count)")
        }
        ConexionWS.getDatos("niveles-educacion/?limit=10"){ result in
            self.nivelesEduc = NivelEducacion.dataNivelEduc(result)
            println("niveles de educacion: \(self.nivelesEduc.count)")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}