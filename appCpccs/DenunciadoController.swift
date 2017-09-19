//
//  DenunciadoController.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 18/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class DenunciadoController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    var provinciasEC: Array<Provincia>!
    
    let pickerCiudades = UIPickerView()
    let pickerGenero = UIPickerView()
    
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtCiudad: UITextField!
    
    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtInstitucion: UITextField!
    @IBOutlet weak var txtCargo: UITextField!
    @IBOutlet weak var txtParroquia: UITextField!
    
    
    var genero = ["Masculino","Femenino","LGBTI"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConexionWS.getDatos("provincias/?limit=100"){ result in
            self.provinciasEC = Provincia.dataProvincias(result)
            println("Provincias: \(self.provinciasEC.count)")
        }
        pickerCiudades.delegate = self
        pickerGenero.delegate = self
        cargarPickers()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == pickerCiudades{
            return 2
        }
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = 0
        if pickerView == pickerGenero {
            return self.genero.count
        }else if pickerView == pickerCiudades{
            if component == 0 {
                return self.provinciasEC.count
            }
            return self.provinciasEC[pickerView.selectedRowInComponent(0)].ciudades.count
        }
        return countrows
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerCiudades{
            if component == 0 {
                pickerCiudades.reloadComponent(1)
                pickerCiudades.selectRow(0, inComponent: 1, animated: true)
            }
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView == pickerGenero {
            return self.genero[row]
        }else if pickerView == pickerCiudades{
            if component == 0{
                return self.provinciasEC[row].nombre
            }
            return self.provinciasEC[pickerView.selectedRowInComponent(0)].ciudades[row].nombre
        }
        return "error"
    }
    @IBAction func btnADenunciado(sender: UIButton, forEvent event: UIEvent) {
        if txtNombres.text.isEmpty || txtApellidos.text.isEmpty || txtInstitucion.text.isEmpty || txtCargo.text.isEmpty{
            let alertController = UIAlertController(title: "Error", message: "Debe completar los campos para pasar a la siguiente parte de su denuncia", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                println("you have pressed Yes button");
                //Call another alert here
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    func cargarPickers(){
        let toolbarCiudad = UIToolbar()
        toolbarCiudad.sizeToFit()
        let doneCiudadButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "doneCiudadPressed")
        toolbarCiudad.setItems([doneCiudadButton], animated: false)
        txtCiudad.inputAccessoryView = toolbarCiudad
        txtCiudad.inputView = pickerCiudades
        
        let toolbarGenero = UIToolbar()
        toolbarGenero.sizeToFit()
        let doneGeneroButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "doneGeneroPressed")
        toolbarGenero.setItems([doneGeneroButton], animated: false)
        txtGenero.inputAccessoryView = toolbarGenero
        txtGenero.inputView = pickerGenero
    }
    func doneCiudadPressed(){
        let row = pickerCiudades.selectedRowInComponent(0)
        let row2 = pickerCiudades.selectedRowInComponent(1)
        txtCiudad.text = "\(provinciasEC[row].nombre), \(provinciasEC[row].ciudades[row2].nombre)"
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