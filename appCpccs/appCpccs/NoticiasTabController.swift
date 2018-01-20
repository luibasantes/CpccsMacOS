//
//  NoticiasTabController.swift
//  appCpccs
//
//  Created by Sistemas Operativos on 8/9/17.
//  Copyright (c) 2017 Espol. All rights reserved.
//

import Foundation
import UIKit
import Kanna
import Alamofire


class NoticiasTabController : UIViewController,NSXMLParserDelegate{
    
    @IBOutlet weak var scrollMaster: UIScrollView!
    var img: Array<String>!
    var links: Array<String>!
    var titles: Array<String>!
    var buttons: Array<UIButton>!
    var maxWidth : CGFloat!
    let url = "http://www.cpccs.gob.ec/es/category/boletines/"
    var parser: NSXMLParser!
    var element: String!
    let file = "HTMLnot.txt"
    let alertController = UIAlertController(title: "Realizando solicitud", message: "Cargando Noticias...", preferredStyle: UIAlertControllerStyle.Alert)
    
    func showAlert(){
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func dismissAlert(){
        self.alertController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func mostrarNoticias(sender: UIButton!){
        for i in 0...(buttons.count - 1){
            if(sender == buttons[i]){
                let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let viewController = storyboard.instantiateViewControllerWithIdentifier("NoticiasViewerController") as! noticiasViewerController
                viewController.link = self.links[i]
                self.presentViewController(viewController, animated:true, completion:nil)
            }
        }
    }
    
    override func  viewDidLoad() {
        self.img = []
        self.titles = []
        self.links = []
        self.buttons = []
        self.maxWidth = 0
        self.scrape()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.showAlert()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollMaster.contentSize = CGSize(width:self.maxWidth, height: 0)
        super.viewDidLayoutSubviews()
        
    }
    
    //XMLParser Methods
    
    func scrape() -> Void {
        Alamofire.request(NSURLRequest(URL:NSURL(string: url)!)).responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTML(html)
            }
        }
    }
    

    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) {
            
            // Search for nodes by CSS selector
            for article in doc.xpath("//article"){
                let wrap = article.at_xpath(".//div[@class='blog-wrap']")
                let image = wrap!.at_xpath(".//div[@class='entry blog-media']")
                let img_url = image!.at_xpath(".//a")!.at_xpath(".//img/@src")?.text
                let post_content = wrap!.at_xpath(".//div[@class='post-content']")
                let title = post_content?.at_xpath(".//h2")?.at_xpath(".//a")?.text
                let link = post_content?.at_xpath(".//h2")?.at_xpath(".//a/@href")!.text
                self.img.append(img_url!)
                self.titles.append(title!)
                self.links.append(link!)
            }
            
            self.cargarVistas()
            
        }
    }
    
    func cargarVistas()-> Void{
        var delta : CGFloat = 0
        for i in 0...(titles.count-1){
            let view = UIView(frame: CGRect(x: 20 + delta, y: self.scrollMaster.frame.height/6, width: 230, height: self.scrollMaster.frame.height * 3/4))
            let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 230, height: view.frame.height * 3/4))
            let button = UIButton(frame: CGRect(x: 0, y: image.frame.height, width: 230, height: view.frame.height * 1/4))
            button.setTitle(titles[i], forState: UIControlState.Normal)
            button.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.addTarget(self, action: "mostrarNoticias:", forControlEvents: UIControlEvents.TouchUpInside)
            button.titleLabel?.font = UIFont.systemFontOfSize(9)
            button.titleLabel?.numberOfLines = 3
            let url:NSURL = NSURL(string: img[i])!
            let data:NSData = NSData(contentsOfURL: url)!
            image.image = UIImage(data: data)
            view.addSubview(image)
            view.addSubview(button)
            buttons.append(button)
            scrollMaster.addSubview(view)
            delta = view.frame.maxX
         }
         
         let left = UIImageView(frame: CGRect(x: 0, y: self.scrollMaster.frame.height/2, width: 30, height: 30))
         left.image = UIImage(named: "left arrow.png")
         let right = UIImageView(frame: CGRect(x: self.view.frame.width-30, y: self.scrollMaster.frame.height/2, width: 30, height: 30))
         right.image = UIImage(named: "right arrow.png")
         
         self.view.addSubview(left)
         self.view.addSubview(right)
         scrollMaster.frame = CGRect(x: scrollMaster.frame.minX, y: scrollMaster.frame.minY, width: self.view.frame.width, height: scrollMaster.frame.height)
         maxWidth = delta
        
         scrollMaster.contentSize = CGSizeMake(scrollMaster.contentSize.width,scrollMaster.frame.size.height);
        
         self.dismissAlert()

    }
    
}