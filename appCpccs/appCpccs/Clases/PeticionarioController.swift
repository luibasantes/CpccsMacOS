//
//  Peticionario.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 21/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//


import Foundation
import UIKit

class PeticionarioController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    var provinciasEC: Array<Provincia>!
    var ciudadesEC: Array<Ciudad>!
    var etniasEC: Array<Etnia>!
    var estadosC: Array<EstadoCivil>!
    var nivelesEduc: Array<NivelEducacion>!
    
    var datosDenuncia: Denuncia!
    
    let pickerCiudades = UIPickerView()
    let pickerGenero = UIPickerView()
    let pickerEtnia = UIPickerView()
    let pickerEducacion = UIPickerView()
    
    @IBOutlet weak var optIdentidad: UISwitch!
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtEducacion: UITextField!
    @IBOutlet weak var txtEtnia: UITextField!
    @IBOutlet weak var txtCiudad: UITextField!
    
    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var txtCelular: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtInstitucion: UITextField!
    @IBOutlet weak var txtCargo: UITextField!
    @IBOutlet weak var optId: UISegmentedControl!
    @IBOutlet weak var txtCed: UITextField!
    @IBOutlet weak var txtPais: UITextField!
    
    
    
    var genero = ["MASCULINO","FEMENINO","LGBTI"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConexionWS.getDatos("provincias/?limit=100"){ result in
            self.provinciasEC = Provincia.dataProvincias(result)
        }
        ConexionWS.getDatos("etnias/?limit=10"){ result in
            self.etniasEC = Etnia.dataEtnia(result)
        }
        ConexionWS.getDatos("estados-civiles/?limit=10"){ result in
            self.estadosC = EstadoCivil.dataEstadoC(result)
        }
        ConexionWS.getDatos("niveles-educacion/?limit=10"){ result in
            self.nivelesEduc = NivelEducacion.dataNivelEduc(result)
        }
        pickerCiudades.delegate = self
        pickerEtnia.delegate = self
        pickerEducacion.delegate = self
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
        if pickerView == pickerEducacion {
            return self.nivelesEduc.count
        }else if pickerView == pickerEtnia {
            return self.etniasEC.count
        }else if pickerView == pickerGenero {
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
        if pickerView == pickerEducacion {
            return self.nivelesEduc[row].descripcion
        }else if pickerView == pickerEtnia {
            return self.etniasEC[row].nombre
        }else if pickerView == pickerGenero {
            return self.genero[row]
        }else if pickerView == pickerCiudades{
            if component == 0{
                pickerView.selectRow(0, inComponent: 1, animated: false)
                return self.provinciasEC[row].nombre
            }else if component == 1 {
                return self.provinciasEC[pickerCiudades.selectedRowInComponent(0)].ciudades[row].nombre
            }
            
        }
        return "error"
    }
    @IBAction func btnADenunciado(sender: UIButton) {
        if txtNombres.text.isEmpty || txtApellidos.text.isEmpty || txtEdad.text.isEmpty || txtCorreo.text.isEmpty || txtTelefono.text.isEmpty || txtDireccion.text.isEmpty || txtInstitucion.text.isEmpty || txtCed.text.isEmpty || txtPais.text.isEmpty{
            
            let alertController = UIAlertController(title: "Error", message: "Debe completar los campos para pasar a la siguiente parte de su denuncia", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction?) in
                println("you have pressed Yes button");
                //Call another alert here
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        }
        else{
            recolectarDatos()
        }
    }
    func recolectarDatos(){
        var datos: Denuncia = Denuncia()
        datos.identidad_reservada = self.optIdentidad.selected
        datos.nombres_apellidos_denunciante = "\(self.txtNombres) \(self.txtApellidos)"
        datos.edad_denunciante = self.txtEdad.text.toInt()
        datos.correo_denunciante = self.txtCorreo.text
        datos.telefono = self.txtTelefono.text
        datos.celular = self.txtCelular.text
        datos.direccion = self.txtDireccion.text
        var prov: [String]
        prov=self.txtCiudad.text.componentsSeparatedByString(", ")
        datos.provincia_denunciante_id = Provincia.buscarProvinciaId(self.provinciasEC,provinciaBuscar: prov[0])
        var listaCiudades: Array<Ciudad> = self.provinciasEC[pickerCiudades.selectedRowInComponent(0)].ciudades
        datos.ciudad_denunciante_id = Ciudad.buscarCiudadId(listaCiudades, ciudadBuscar: prov[1])
        datos.genero_denunciante = self.txtGenero.text
        datos.etnia = self.pickerEtnia.selectedRowInComponent(0)
        datos.nivel_educacion_id = self.pickerEducacion.selectedRowInComponent(0)
        datos.institucion_denunciante = self.txtInstitucion.text
        datos.cargo_denunciante = self.txtCargo.text
        if optId.selectedSegmentIndex == 0 {
            datos.tipo_identificacion = "CEDULA"
        }else {
            datos.tipo_identificacion = "PASAPORTE"
        }
        datos.no_identificacion = self.txtCed.text
        datos.pais = self.txtPais.text
        self.datosDenuncia = datos
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
        let row2 = pickerCiudades.selectedRowInComponent(1)
        txtCiudad.text = "\(provinciasEC[row].nombre), \(provinciasEC[row].ciudades[row2].nombre)"
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destino = segue.destinationViewController as? EvidenciaController {
            destino.datos = self.datosDenuncia
        }
    }
}
