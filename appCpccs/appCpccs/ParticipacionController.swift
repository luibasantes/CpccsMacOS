//
//  ParticipacionController.swift
//  appCpccs
//
//  Created by jjcrow on 9/18/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIkit

class ParticipacionController : UIViewController{
    
    
    @IBOutlet weak var scrollMaster: UIScrollView!
    var contenidos : Array<ContenidoParticipacionCiudadana>!
    var buttonArray: Array<UIButton>!
    var videoButtonArray: Array<UIButton>!
    var textArray: Array<UITextView>!
    var indexVideoArray: Array<Int>!
    var linkVideo : String!
    
    func showView(sender: UIButton!){
        var delta : CGFloat
        for i in 0...(buttonArray.count-1){
            if(sender == buttonArray[i]){
                if(textArray[i].frame.height == 0){
                    textArray[i].frame = CGRect(x: textArray[i].frame.minX, y: textArray[i].frame.minY, width: textArray[i].frame.width, height: 70)
                    delta = 80
                    
                    if(indexVideoArray[i] != -1){
                        var index = indexVideoArray[i]
                        videoButtonArray[index].frame = CGRect(x: videoButtonArray[index].frame.minX, y: videoButtonArray[index].frame.minY + delta, width: self.view.frame.width - 60, height: 40)
                        delta = delta + 50
                    }
                    
                    if(i+1 != buttonArray.count){
                        
                        for j in (i+1)...(buttonArray.count-1){
                            buttonArray[j].frame = CGRect(x: buttonArray[j].frame.minX, y: buttonArray[j].frame.minY + delta, width: buttonArray[j].frame.width, height: buttonArray[j].frame.height)
                            textArray[j].frame = CGRect(x: textArray[j].frame.minX, y: textArray[j].frame.minY+delta, width: textArray[j].frame.width, height: textArray[j].frame.height)
                            if(indexVideoArray[j] != -1){
                                var index = indexVideoArray[j]
                                videoButtonArray[index].frame = CGRect(x: videoButtonArray[index].frame.minX, y: videoButtonArray[index].frame.minY + delta, width: videoButtonArray[index].frame.width, height: videoButtonArray[index].frame.height)
                            }
                        }
                    }
                }
                else{
                    textArray[i].frame = CGRect(x: textArray[i].frame.minX, y: textArray[i].frame.minY, width: textArray[i].frame.width, height: 0)
                    delta = 80
                    
                    if(indexVideoArray[i] != -1){
                        var index = indexVideoArray[i]
                        videoButtonArray[index].frame = CGRect(x: videoButtonArray[index].frame.minX, y: videoButtonArray[index].frame.minY - delta, width: 0, height: 0)
                        delta = delta + 50
                    }
                    
                    if(i+1 != buttonArray.count){
                        for j in (i+1)...(buttonArray.count-1){
                            buttonArray[j].frame = CGRect(x: buttonArray[j].frame.minX, y: buttonArray[j].frame.minY - delta, width: buttonArray[j].frame.width, height: buttonArray[j].frame.height)
                            textArray[j].frame = CGRect(x: textArray[j].frame.minX, y: textArray[j].frame.minY-delta, width: textArray[j].frame.width, height: textArray[j].frame.height)
                            if(indexVideoArray[j] != -1){
                                var index = indexVideoArray[j]
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
               var linkIndex = find(indexVideoArray, i)
                if(linkIndex != nil){
                    self.linkVideo = contenidos[linkIndex!].link
                    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    var videoController = storyboard.instantiateViewControllerWithIdentifier("VideoController") as VideoController
                    videoController.link = self.linkVideo
                    self.presentViewController(videoController, animated:true, completion:nil)
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        
        
        ConexionWS.getDatos("contenidos/?limit=100"){
            result in dispatch_async(dispatch_get_main_queue()){
                self.contenidos = ContenidoParticipacionCiudadana.getContenido(result)
                self.buttonArray = []
                self.textArray = []
                self.videoButtonArray = []
                self.indexVideoArray = []
                var yPos : CGFloat! = 0
                for contenido in self.contenidos{
                    var button = UIButton(frame: CGRect(x:0, y: yPos, width: self.view.frame.width, height: 30))
                    button.setTitle(contenido.titulo, forState: UIControlState.Normal)
                    button.setBackgroundImage(UIImage(named: "bar item.png"), forState: UIControlState.Normal)
                    button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                    button.addTarget(self, action: "showView:", forControlEvents: UIControlEvents.TouchUpInside)
                    
                    var textView = UITextView(frame: CGRect(x: 10, y: button.frame.maxY, width: self.view.frame.width - 20, height: 0))
                    textView.text = contenido.descripcion
                    textView.textAlignment = NSTextAlignment.Justified
                    textView.backgroundColor = UIColor(white: 0.5, alpha: 0.2)
                    textView.layer.cornerRadius = 10
                    textView.editable = false
                    
                    self.scrollMaster.addSubview(button)
                    self.scrollMaster.addSubview(textView)
                    yPos = textView.frame.maxY
                    self.buttonArray.append(button)
                    self.textArray.append(textView)
                    
                    if(contenido.link != "ninguno"){
                        var buttonVideo = UIButton(frame: CGRect(x: 30, y: textView.frame.maxY, width: 0, height: 0))
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
                }
            }
        }
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}