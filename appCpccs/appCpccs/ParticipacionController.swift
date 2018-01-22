//
//  ParticipacionController.swift
//  appCpccs
//
//  Created by jjcrow on 9/18/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit

class ParticipacionController : UIViewController{
    
    
    @IBOutlet weak var scrollMaster: UIScrollView!
    var contenidos : Array<ContenidoParticipacionCiudadana>!
    var buttonArray: Array<UIButton>!
    var videoButtonArray: Array<UIButton>!
    var textArray: Array<UITextView>!
    var indexVideoArray: Array<Int>!
    var linkVideo : String!
    var maxHeight : CGFloat!
    var loaded = false
    let errorAlert = UIAlertController(title: "Solicitud Fallida", message: "No se puede conectar al servirdor, intente luego", preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
        print("OK button tapped")
    })
    let progressAlert = UIAlertController(title: "Enviando Solicitud", message: "Cargando datos..", preferredStyle: UIAlertControllerStyle.Alert)
    
    func showError(){
        errorAlert.addAction(okAction)
        presentViewController(errorAlert, animated: true, completion: nil)
    }
    
    func showProgress(){
        presentViewController(progressAlert, animated: true, completion: nil)
    }
    
    func dismissProgress(){
        self.progressAlert.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showView(sender: UIButton!){
        var delta : CGFloat
        for i in 0...(buttonArray.count-1){
            if(sender == buttonArray[i]){
                if(textArray[i].frame.height == 0){
                    textArray[i].frame = CGRect(x: textArray[i].frame.minX, y: textArray[i].frame.minY, width: textArray[i].frame.width, height: self.scrollMaster.frame.height)
                    delta = 80
                    
                    if(indexVideoArray[i] != -1){
                        let index = indexVideoArray[i]
                        videoButtonArray[index].frame = CGRect(x: videoButtonArray[index].frame.minX, y: videoButtonArray[index].frame.minY + delta, width: self.view.frame.width - 60, height: 40)
                        delta = delta + 50
                    }
                    
                    if(i+1 != buttonArray.count){
                        
                        for j in (i+1)...(buttonArray.count-1){
                            buttonArray[j].frame = CGRect(x: buttonArray[j].frame.minX, y: buttonArray[j].frame.minY + delta, width: buttonArray[j].frame.width, height: buttonArray[j].frame.height)
                            textArray[j].frame = CGRect(x: textArray[j].frame.minX, y: textArray[j].frame.minY+delta, width: textArray[j].frame.width, height: textArray[j].frame.height)
                            if(indexVideoArray[j] != -1){
                                let index = indexVideoArray[j]
                                videoButtonArray[index].frame = CGRect(x: videoButtonArray[index].frame.minX, y: videoButtonArray[index].frame.minY + delta, width: videoButtonArray[index].frame.width, height: videoButtonArray[index].frame.height)
                            }
                        }
                    }
                }
                else{
                    textArray[i].frame = CGRect(x: textArray[i].frame.minX, y: textArray[i].frame.minY, width: textArray[i].frame.width, height: 0)
                    delta = 80
                    
                    if(indexVideoArray[i] != -1){
                        let index = indexVideoArray[i]
                        videoButtonArray[index].frame = CGRect(x: videoButtonArray[index].frame.minX, y: videoButtonArray[index].frame.minY - delta, width: 0, height: 0)
                        delta = delta + 50
                    }
                    
                    if(i+1 != buttonArray.count){
                        for j in (i+1)...(buttonArray.count-1){
                            buttonArray[j].frame = CGRect(x: buttonArray[j].frame.minX, y: buttonArray[j].frame.minY - delta, width: buttonArray[j].frame.width, height: buttonArray[j].frame.height)
                            textArray[j].frame = CGRect(x: textArray[j].frame.minX, y: textArray[j].frame.minY-delta, width: textArray[j].frame.width, height: textArray[j].frame.height)
                            if(indexVideoArray[j] != -1){
                                let index = indexVideoArray[j]
                                videoButtonArray[index].frame = CGRect(x: videoButtonArray[index].frame.minX, y: videoButtonArray[index].frame.minY - delta, width: videoButtonArray[index].frame.width, height: videoButtonArray[index].frame.height)
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    func showVideo(sender: UIButton!){
        for i in 0...(videoButtonArray.count-1){
            if(sender == videoButtonArray[i]){
               let linkIndex = indexVideoArray.indexOf(i)
                if(linkIndex != nil){
                    self.linkVideo = contenidos[linkIndex!].link
                    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    let videoController = storyboard.instantiateViewControllerWithIdentifier("VideoController") as! VideoController
                    videoController.link = self.linkVideo
                    self.presentViewController(videoController, animated:true, completion:nil)
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        self.maxHeight = 0
        ConexionWS.getDatos("contenidos/"){
            result in dispatch_async(dispatch_get_main_queue()){
                if(result.length != 5){
                    self.contenidos = ContenidoParticipacionCiudadana.getContenido(result)
                    self.buttonArray = []
                    self.textArray = []
                    self.videoButtonArray = []
                    self.indexVideoArray = []
                    var yPos : CGFloat! = 0
                    for contenido in self.contenidos{
                        let button = UIButton(frame: CGRect(x:0, y: yPos, width: self.view.frame.width, height: self.scrollMaster.frame.height * 1/4))
                        button.setTitle(contenido.titulo, forState: UIControlState.Normal)
                        button.setBackgroundImage(UIImage(named: "bar item.png"), forState: UIControlState.Normal)
                        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                        button.addTarget(self, action: "showView:", forControlEvents: UIControlEvents.TouchUpInside)
                        //Agregado recientemente
                        button.titleLabel?.font = UIFont.boldSystemFontOfSize(13)
                        button.titleLabel!.numberOfLines = 5;
                        button.titleLabel!.adjustsFontSizeToFitWidth = true;
                        button.titleLabel!.lineBreakMode = NSLineBreakMode.ByClipping;
                        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
                        button.contentVerticalAlignment = UIControlContentVerticalAlignment.Center;
                        button.contentEdgeInsets.left  = self.scrollMaster.frame.width * 1/4
                        
                        
                        let textView = UITextView(frame: CGRect(x: 10, y: button.frame.maxY, width: self.view.frame.width - 20, height: 0))
                        textView.text = contenido.descripcion
                        textView.textAlignment = NSTextAlignment.Justified
                        textView.backgroundColor = UIColor(white: 0.5, alpha: 0.2)
                        //textView.layer.cornerRadius = 10
                        textView.editable = false
                        //Agregado recientemente
                        textView.font = UIFont(name: (textView.font?.fontName)!, size: 12)
                        
                        self.scrollMaster.addSubview(button)
                        self.scrollMaster.addSubview(textView)
                        yPos = textView.frame.maxY
                        self.buttonArray.append(button)
                        self.textArray.append(textView)
                        
                        if(contenido.link != "ninguno"){
                            let buttonVideo = UIButton(frame: CGRect(x: 30, y: textView.frame.maxY, width: 0, height: 0))
                            buttonVideo.setTitle("Toque para ver video", forState: UIControlState.Normal)
                            buttonVideo.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                            buttonVideo.backgroundColor = UIColor.redColor()
                            buttonVideo.addTarget(self, action: "showVideo:", forControlEvents: UIControlEvents.TouchUpInside)
                            self.scrollMaster.addSubview(buttonVideo)
                            self.videoButtonArray.append(buttonVideo)
                            self.indexVideoArray.append(self.videoButtonArray.count-1)
                            yPos = buttonVideo.frame.maxY
                        }
                        else{
                            self.indexVideoArray.append(-1)
                        }
                        self.maxHeight = yPos
                    }
                    self.loaded = true
                    self.dismissProgress()
                }
                else{
                    self.dismissProgress()
                    print("ERROR DE CONEXION")
                    self.showError()
                    self.loaded = false
                }
            }
        }
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if(!loaded){
            showProgress()
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollMaster.contentSize = CGSize(width:0, height: self.maxHeight * 3)
        super.viewDidLayoutSubviews()
        
    }
}