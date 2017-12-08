//
//  FormatVC.swift
//  Client
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa

class FormatVC: NSViewController {
    
    @IBOutlet weak var xmlButton: NSButton!
    @IBOutlet weak var jsonButton: NSButton!
    
    var requestPackage: RequestPackage!
    
    override func viewDidLoad() {
        
        if requestPackage.format == "JSON" {
           jsonButton.image = NSImage(imageLiteralResourceName: "json_selected")
        }
        
        if requestPackage.format == "XML" {
            xmlButton.image = NSImage(imageLiteralResourceName: "xml_selected")
        }
        
    }
    
    @IBAction func jsonBtnPressed(_ sender: Any) {
        
        if requestPackage.format != "JSON" {
            requestPackage.setFormat(value: "JSON")
            jsonButton.image = NSImage(imageLiteralResourceName: "json_selected")
            xmlButton.image = NSImage(imageLiteralResourceName: "xml")
        } else {
            requestPackage.setFormat(value: "NONE")
            jsonButton.image = NSImage(imageLiteralResourceName: "json")
        }
        
    }
    
    @IBAction func xmlButtonPressed(_ sender: Any) {
        
        if requestPackage.format != "XML" {
            requestPackage.setFormat(value: "XML")
            xmlButton.image = NSImage(imageLiteralResourceName: "xml_selected")
            jsonButton.image = NSImage(imageLiteralResourceName: "json")
        } else {
            requestPackage.setFormat(value: "NONE")
            xmlButton.image = NSImage(imageLiteralResourceName: "xml")
        }
        
    }
    
    
    
    
    
    
}
