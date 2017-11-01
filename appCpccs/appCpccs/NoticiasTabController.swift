//
//  NoticiasTabController.swift
//  appCpccs
//
//  Created by Sistemas Operativos on 8/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIkit

class NoticiasTabController : UIViewController,NSXMLParserDelegate{
    
    @IBOutlet weak var scrollMaster: UIScrollView!
    var img: Array<String>!
    var links: Array<String>!
    var titles: Array<String>!
    var buttons: Array<UIButton>!
    var maxWidth : CGFloat!
    let url = "http://www.cpccs.gob.ec/es/category/noticias/"
    var parser: NSXMLParser!
    var element: String!
    let file = "HTMLnot.txt"
    
    func mostrarNoticias(sender: UIButton!){
        for i in 0...(buttons.count - 1){
            if(sender == buttons[i]){
                let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                var viewController = storyboard.instantiateViewControllerWithIdentifier("NoticiasViewerController") as noticiasViewerController
                viewController.link = self.links[i]
                self.presentViewController(viewController, animated:true, completion:nil)
            }
        }
    }
    
    override func  viewDidLoad() {
        self.img = ["not_img1.png","not_img2.png","not_img3.jpg","not_img4.jpg","not_img5.jpg","not_img6.jpg","not_img7.jpg","not_img8.jpg"]
        self.titles = ["CPCCS APRUEBA PLAN DE EVACUACIÓN DE VEEDURÍAS","Sesión Ordinaria No. 82","Boletín de Prensa N° 410","Boletín de Prensa N° 409","TRES SECTORES DE GUAYAS ELIGIERON REPRESENTANTES A CONSEJOS BARRIALES","Boletín de Prensa No. 408","Boletín de Prensa No. 407","GUAYAS PROMUEVE LA TRANSPARENCIA CON 32 JÓVENES BRIGADISTAS"]
        self.links = ["http://www.cpccs.gob.ec/es/cpccs-aprueba-plan-de-evacuacion-de-veedurias/","http://www.cpccs.gob.ec/es/comision-ciudadana-de-concurso-para-designar-contralor-general-del-estado-aprobo-informe-de-calificacion-de-meritos-2/","http://www.cpccs.gob.ec/es/boletin-de-prensa-n-410/","http://www.cpccs.gob.ec/es/boletin-de-prensa-n-409/","http://www.cpccs.gob.ec/es/tres-sectores-de-guayas-eligieron-representantes-a-consejos-barriales/","http://www.cpccs.gob.ec/es/boletin-de-prensa-no-408/","http://www.cpccs.gob.ec/es/boletin-de-prensa-no-407/","http://www.cpccs.gob.ec/es/guayas-promueve-la-transparencia-con-32-jovenes-brigadistas/"]
        self.buttons = []
        var delta : CGFloat = 0
        self.maxWidth = 0
        for i in 0...(titles.count-1){
            var view = UIView(frame: CGRect(x: 20 + delta, y: 10, width: 230, height: 200))
            var image = UIImageView(frame: CGRect(x: 0, y: 0, width: 230, height: 150))
            var button = UIButton(frame: CGRect(x: 0, y: 150, width: 230, height: 50))
            button.setTitle(titles[i], forState: UIControlState.Normal)
            button.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 0.8)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.addTarget(self, action: "mostrarNoticias:", forControlEvents: UIControlEvents.TouchUpInside)
            image.image = UIImage(named: img[i])
            view.addSubview(image)
            view.addSubview(button)
            buttons.append(button)
            scrollMaster.addSubview(view)
            delta = view.frame.maxX
        }
        
        var left = UIImageView(frame: CGRect(x: 0, y: self.scrollMaster.frame.height/2, width: 30, height: 30))
        left.image = UIImage(named: "left arrow.png")
        var right = UIImageView(frame: CGRect(x: self.view.frame.width-30, y: self.scrollMaster.frame.height/2, width: 30, height: 30))
        right.image = UIImage(named: "right arrow.png")
        
        self.view.addSubview(left)
        self.view.addSubview(right)
        scrollMaster.frame = CGRect(x: scrollMaster.frame.minX, y: scrollMaster.frame.minY, width: self.view.frame.width, height: scrollMaster.frame.height)
        maxWidth = delta
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollMaster.contentSize = CGSize(width:self.maxWidth, height: 355)
        super.viewDidLayoutSubviews()
        
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        println("THIS ELEMENT: \(elementName)")
        if (elementName as NSString).isEqualToString("article")
        {
            println("This is an article tag!")
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("item") {
            
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
            println("This content: \(string)")
    }
    
}