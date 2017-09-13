//
//  DenunciasController.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 7/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class DenunciasController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    @IBOutlet weak var txtProvincias: UITextView!
    var provinciasEC: Array<Provincia>!
    var ciudadesEC: Array<Ciudad>!
    var etniasEC: Array<Etnia>!
    var estadosC: Array<EstadoCivil>!
    var nivelesEduc: Array<NivelEducacion>!

    
    let pickerCiudades = UIPickerView()
    let pickerGenero = UIPickerView()
    let pickerEtnia = UIPickerView()
    let pickerEducacion = UIPickerView()
    
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtEducacion: UITextField!
    @IBOutlet weak var txtEtnia: UITextField!
    @IBOutlet weak var txtCiudad: UITextField!
    
    var genero = ["Masculino","Femenino","LGBTI"]
    
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
        pickerCiudades.delegate = self
        pickerEtnia.delegate = self
        pickerEducacion.delegate = self
        pickerGenero.delegate = self
        cargarPickers()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == pickerCiudades{
            return 1
        }
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = 0
        if pickerView == pickerEducacion {
            return self.nivelesEduc.count
        }else if pickerView == pickerEtnia {
            return self.etniasEC.count
        }else if pickerView == pickerGenero {
            return self.genero.count
        }else if pickerView == pickerCiudades{
            return self.ciudadesEC.count
        }
        return countrows
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView == pickerEducacion {
            return self.nivelesEduc[row].descripcion
        }else if pickerView == pickerEtnia {
            return self.etniasEC[row].nombre
        }else if pickerView == pickerGenero {
            return self.genero[row]
        }else if pickerView == pickerCiudades{
            return self.ciudadesEC[row].nombre
        }
        return "error"
    }
    func cargarPickers(){
        let toolbarCiudad = UIToolbar()
        toolbarCiudad.sizeToFit()
        let doneCiudadButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "doneCiudadPressed")
        toolbarCiudad.setItems([doneCiudadButton], animated: false)
        txtCiudad.inputAccessoryView = toolbarCiudad
        txtCiudad.inputView = pickerCiudades
        
        let toolbarEtnia = UIToolbar()
        toolbarEtnia.sizeToFit()
        let doneEtniaButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "doneEtniaPressed")
        toolbarEtnia.setItems([doneEtniaButton], animated: false)
        txtEtnia.inputAccessoryView = toolbarEtnia
        txtEtnia.inputView = pickerEtnia
        
        let toolbarEducacion = UIToolbar()
        toolbarEducacion.sizeToFit()
        let doneEducacionButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "doneEducacionPressed")
        toolbarEducacion.setItems([doneEducacionButton], animated: false)
        txtEducacion.inputAccessoryView = toolbarEducacion
        txtEducacion.inputView = pickerEducacion
        
        let toolbarGenero = UIToolbar()
        toolbarGenero.sizeToFit()
        let doneGeneroButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "doneGeneroPressed")
        toolbarGenero.setItems([doneGeneroButton], animated: false)
        txtGenero.inputAccessoryView = toolbarGenero
        txtGenero.inputView = pickerGenero
    }
    func doneCiudadPressed(){
        let row = pickerCiudades.selectedRowInComponent(0)
        txtCiudad.text = "\(ciudadesEC[row].nombre)"
        self.view.endEditing(true)
    }
    func doneEtniaPressed(){
        let row = pickerEtnia.selectedRowInComponent(0)
        txtEtnia.text = "\(etniasEC[row].nombre)"
        self.view.endEditing(true)
    }
    func doneEducacionPressed(){
        let row = pickerEducacion.selectedRowInComponent(0)
        txtEducacion.text = "\(nivelesEduc[row].nombre)"
        self.view.endEditing(true)
    }
    func doneGeneroPressed(){
        let row = pickerGenero.selectedRowInComponent(0)
        txtGenero.text = "\(genero[row])"
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}