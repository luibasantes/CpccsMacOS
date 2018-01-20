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
    var generosEC: Array<Genero>!
    
    let pickerCiudades = UIPickerView()
    let pickerGenero = UIPickerView()
    
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtCiudad: UITextField!
    
    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtInstitucion: UITextField!
    @IBOutlet weak var txtCargo: UITextField!
    @IBOutlet weak var txtParroquia: UITextField!
    
    let successAlert = UIAlertController(title: "Envio exitoso", message: "Se ha enviado con exito la denuncia!", preferredStyle: UIAlertControllerStyle.Alert)
    
    func showSucess(doAction : () -> Void){
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
            doAction()
        })
        successAlert.addAction(okAction)
        presentViewController(successAlert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConexionWS.getDatos("provincias/?limit=100"){ result in
            self.provinciasEC = Provincia.dataProvincias(result)
            print(self.datosDenuncia.no_identificacion, terminator: "")
        }
        ConexionWS.getDatos("generos/?limit=10"){ result in
            self.generosEC = Genero.dataGenero(result)
            print(self.datosDenuncia.no_identificacion, terminator: "")
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
        let countrows : Int = 0
        if pickerView == pickerGenero {
            return self.generosEC.count
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
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerGenero {
            return self.generosEC[row].nombre
        }else if pickerView == pickerCiudades{
            if component == 0{
                return self.provinciasEC[row].nombre
            }
            return self.provinciasEC[pickerView.selectedRowInComponent(0)].ciudades[row].nombre
        }
        return "error"
    }
    @IBAction func btnADenunciado(sender: UIButton, forEvent event: UIEvent) {
        if self.txtNombres.text!.isEmpty || self.txtApellidos.text!.isEmpty || self.txtInstitucion.text!.isEmpty || self.txtCargo.text!.isEmpty || self.txtGenero.text!.isEmpty || self.txtCiudad.text!.isEmpty || self.txtParroquia.text!.isEmpty{
            let alertController = UIAlertController(title: "Error", message: "Debe completar los campos para pasar a la siguiente parte de su denuncia", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction) in
                print("you have pressed Yes button");
                //Call another alert here
            }
            let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action:UIAlertAction) in
                print("you have pressed Yes button");
                //Call another alert here
            }
            alertController.addAction(CancelAction)
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        }else {
            recolectarDatosDenunciado()
            let alertController = UIAlertController(title: "AVISO", message: "Al presionar OK, enviará su denuncia al CPCCS para su verificación", preferredStyle: .Alert)
            _ = UIAlertAction(title: "BACK", style: .Default) { (action:UIAlertAction) in
                print("you have pressed Yes button");
                //Call another alert here
            }
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction) in
                print("you have pressed Yes button");
                self.enviarDenuncia(){() in dispatch_async(dispatch_get_main_queue()){
                    self.showSucess({() in
                        print("Entering to storyBoard")
                        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                        let viewController = storyboard.instantiateViewControllerWithIdentifier("menuViewController") as! menuViewController
                        self.presentViewController(viewController, animated:true, completion:nil)
                    })
                    }
                }
                //Call another alert here
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    func recolectarDatosDenunciado(){
        self.datosDenuncia.nombres_apellidos_denunciado = "\(self.txtNombres.text) \(self.txtApellidos.text)"
        self.datosDenuncia.genero_denunciado = Genero.buscarGeneroId(self.generosEC, generoBuscar: txtGenero.text!)
        self.datosDenuncia.institucion_denunciado = self.txtInstitucion.text
        self.datosDenuncia.cargo_denunciado = self.txtCargo.text
        var prov: [String]
        prov=txtCiudad.text!.componentsSeparatedByString(", ")
        self.datosDenuncia.provincia_denunciado_id = Provincia.buscarProvinciaId(self.provinciasEC,provinciaBuscar: prov[0])
        let listaCiudades: Array<Ciudad> = self.provinciasEC[pickerCiudades.selectedRowInComponent(0)].ciudades
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
        txtGenero.text = "\(generosEC[row].nombre)"
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destino = segue.destinationViewController as? EvidenciaController{
            destino.datos = self.datosDenuncia
            
        }
        
    }
    
    func enviarDenuncia(action: () -> Void){
        //////ejemploooooo
        let username = "cpccs-admin"
        let password = "cpccs2017admin"
        let loginString = NSString(format: "%@:%@",username,password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        
        let url = NSURL(string: "http://190.152.149.89:8181/requerimiento/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let values = "tipodenuncia=\(1) & identidad_reservada=\(self.datosDenuncia.identidad_reservada) &nombres_apellidos_denunciante=\(self.datosDenuncia.nombres_apellidos_denunciante) &edad_denunciante=\(self.datosDenuncia.edad_denunciante) &correo_denunciante=\(self.datosDenuncia.correo_denunciante) &telefono_denunciante=\(self.datosDenuncia.telefono) &celular_denunciante=\(self.datosDenuncia.celular) &direccion_denunciante=\(self.datosDenuncia.direccion) &provincia_denunciante=\(self.datosDenuncia.provincia_denunciante_id) &ciudad_denunciante=\(self.datosDenuncia.ciudad_denunciante_id) &genero_denunciante=\(self.datosDenuncia.genero_denunciante) &estado_civil_denunciante=\(self.datosDenuncia.estadoC) &etnia_denunciante=\(self.datosDenuncia.etnia) &niveleducaciondenunciante=\(self.datosDenuncia.nivel_educacion_id) &institucion_denunciante=\(self.datosDenuncia.institucion_denunciante) &cargo_denunciante=\(self.datosDenuncia.cargo_denunciante) &tipo_identificacion=\(self.datosDenuncia.tipo_identificacion) &identificacion_id=\(self.datosDenuncia.no_identificacion) &pais=\(self.datosDenuncia.pais) &descripcion=\(self.datosDenuncia.descripcion_denuncia) &nombres_apellidos_denunciado=\(self.datosDenuncia.nombres_apellidos_denunciado) &genero_denunciado=\(self.datosDenuncia.genero_denunciado) &institucion_denunciado=\(self.datosDenuncia.institucion_denunciado) &cargo_denunciado=\(self.datosDenuncia.cargo_denunciado) &provincia_denunciado=\(self.datosDenuncia.provincia_denunciado_id) &ciudad_denunciado=\(self.datosDenuncia.ciudad_denunciado_id) &parroquia_denunciado=\(self.datosDenuncia.parroquia_denunciado)"
        
        request.HTTPBody = values.dataUsingEncoding(NSUTF8StringEncoding)
        print(request.HTTPBody, terminator: "")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        let urlConnection = NSURLSession.sharedSession()
        urlConnection.dataTaskWithRequest(request, completionHandler:{(data,response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            if result != nil {
                print(result, terminator: "")
                action()
            }
        }).resume()
        
    }
}