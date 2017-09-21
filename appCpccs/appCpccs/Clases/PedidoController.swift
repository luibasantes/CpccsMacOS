//
//  PedidoController.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 21/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class PedidoController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    var datosDenuncia: Denuncia!
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
            print(self.datosDenuncia.no_identificacion)
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
        if self.txtNombres.text.isEmpty || self.txtApellidos.text.isEmpty || self.txtInstitucion.text.isEmpty || self.txtCargo.text.isEmpty || self.txtGenero.text.isEmpty || self.txtCiudad.text.isEmpty || self.txtParroquia.text.isEmpty{
            let alertController = UIAlertController(title: "Error", message: "Debe completar los campos para pasar a la siguiente parte de su denuncia", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                println("you have pressed Yes button");
                //Call another alert here
            }
            let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action:UIAlertAction!) in
                println("you have pressed Yes button");
                //Call another alert here
            }
            alertController.addAction(CancelAction)
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        }else {
            recolectarDatosDenunciado()
            let alertController = UIAlertController(title: "AVISO", message: "Al presionar OK, enviará su denuncia al CPCCS para su verificación", preferredStyle: .Alert)
            let CancelAction = UIAlertAction(title: "BACK", style: .Default) { (action:UIAlertAction!) in
                println("you have pressed Yes button");
                //Call another alert here
            }
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                println("you have pressed Yes button");
                self.enviarDenuncia()
                //Call another alert here
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    func recolectarDatosDenunciado(){
        self.datosDenuncia.nombres_apellidos_denunciado = "\(self.txtNombres) \(self.txtApellidos)"
        self.datosDenuncia.genero_denunciado = self.txtGenero.text
        self.datosDenuncia.institucion_denunciado = self.txtInstitucion.text
        self.datosDenuncia.cargo_denunciado = self.txtCargo.text
        var prov: [String]
        prov=txtCiudad.text.componentsSeparatedByString(", ")
        self.datosDenuncia.provincia_denunciado_id = Provincia.buscarProvinciaId(self.provinciasEC,provinciaBuscar: prov[0])
        var listaCiudades: Array<Ciudad> = self.provinciasEC[pickerCiudades.selectedRowInComponent(0)].ciudades
        self.datosDenuncia.ciudad_denunciado_id = Ciudad.buscarCiudadId(listaCiudades, ciudadBuscar: prov[1])
        self.datosDenuncia.parroquia_denunciado = self.txtParroquia.text
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destino = segue.destinationViewController as EvidenciaController
        destino.datos = self.datosDenuncia
    }
    
    func enviarDenuncia(){
        //////ejemploooooo
        let username = "cpccs-admin"
        let password = "cpccs2017admin"
        let loginString = NSString(format: "%@:%@",username,password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        let url = NSURL(string: "http://ejrocafuerte.pythonanywhere.com/reclamos/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        var values = "nombres_apellidos_denunciante=\(self.datosDenuncia.nombres_apellidos_denunciante)&tipo_identificacion=\(self.datosDenuncia.tipo_identificacion)&numero_identificacion=\(self.datosDenuncia.no_identificacion)&email=\(self.datosDenuncia.correo_denunciante)&nombres_apellidos_denunciado=\(self.datosDenuncia.nombres_apellidos_denunciado)&ciudad_del_denunciante=\(self.datosDenuncia.ciudad_denunciante_id)&ciudad_del_denunciado=\(self.datosDenuncia.ciudad_denunciado_id)&provincia_denunciante=\(self.datosDenuncia.provincia_denunciante_id)&provincia_denunciado=\(self.datosDenuncia.provincia_denunciado_id)&institucion_implicada=\(2)"
        /*
        tipo=3&genero_denunciante=\(self.datosDenuncia.genero_denunciante)&descripcion_investigacion=\(self.datosDenuncia.descripcion_denuncia)&genero_denunciado=\(self.datosDenuncia.genero_denunciado)&funcionario_publico=senagua&nivel_educacion_denunciante=\(self.datosDenuncia.nivel_educacion_id+1)&ocupacion_denunciante=\(1)&nacionalidad_denunciante=\(1)&estado_civil_denunciante=\(2)
        */
        request.HTTPBody = values.dataUsingEncoding(NSUTF8StringEncoding)
        print(request.HTTPBody)
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        let urlConnection = NSURLSession.sharedSession()
        urlConnection.dataTaskWithRequest(request, completionHandler:{(data,response, error) in
            if error != nil {
                println(error.localizedDescription)
                return
            }
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            if result != nil {
                print(result)
            }
        }).resume()
        
    }
}