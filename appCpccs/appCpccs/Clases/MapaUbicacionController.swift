//
//  MapaUbicacion.swift
//  appCpccs
//
//  Created by Erick Rocafuerte on 20/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class MapaUbicacionController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var txtUbicacion: UITextField!
    var ubicaciones: Array<Ubicacion>!
    let pickerUbicaciones = UIPickerView()
    
    override func viewDidLoad() {
        ConexionWS.getUbicaciones(){ result in
            self.ubicaciones = Ubicacion.dataUbicaciones(result)
        }
        pickerUbicaciones.delegate = self
        mapa.delegate = self
        mapa.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(-1.8604082,-80.1668432), 800000,800000), animated: true)
        cargarPicker()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.ubicaciones.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //aqui debo reajustar el papa con la ubicacion
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.ubicaciones[row].nombre
    }
    func cargarPicker(){
        let toolbarCiudad = UIToolbar()
        toolbarCiudad.sizeToFit()
        let doneCiudadButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "doneCiudadPressed")
        toolbarCiudad.setItems([doneCiudadButton], animated: false)
        txtUbicacion.inputAccessoryView = toolbarCiudad
        txtUbicacion.inputView = pickerUbicaciones
    }
    func doneCiudadPressed(){
        let row = pickerUbicaciones.selectedRowInComponent(0)
        txtUbicacion.text = "\(self.ubicaciones[row].nombre)"
        let coordenadas = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(self.ubicaciones[row].latitud,self.ubicaciones[row].longitud), 200,200)
        mapa.setRegion(coordenadas, animated: true)
        let ubicaAgencia = MarcadorMapa(direccion: self.ubicaciones[row].direccion, telefono: self.ubicaciones[row].telefono,coord: CLLocationCoordinate2DMake(self.ubicaciones[row].latitud, self.ubicaciones[row].longitud))
        if self.mapa.annotations.count > 0 {
            self.mapa.removeAnnotations(self.mapa.annotations)
        }
        self.mapa.addAnnotation(ubicaAgencia)
        self.view.endEditing(true)
    }
}