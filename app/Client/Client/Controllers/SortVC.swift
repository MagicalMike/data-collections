//
//  SortVC.swift
//  Client
//
//  Created by Mihai Petrenco on 12/4/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa

class SortVC: NSViewController {
    
    @IBOutlet weak var ascendingButton: NSButton!
    @IBOutlet weak var descendingButton: NSButton!
    
    var firstVC: MessagingVC!
    var requestPackage: RequestPackage!
    
    var ascendingSelected = false
    var descendingSelected = false
    
    override func viewDidLoad() {
        firstVC = presenting as! MessagingVC
        
        
        for option in requestPackage.options {
            if option["Name"] == "Sort" && option["Value"] == "Ascending" {
                ascendingSelected = true
                ascendingButton.image = NSImage(imageLiteralResourceName: "ascending_selected")
            }
            
            if option["Name"] == "Sort" && option["Value"] == "Descending" {
                descendingSelected = true
                descendingButton.image = NSImage(imageLiteralResourceName: "descending_selected")
            }
        }
        
        
    }
    
    @IBAction func ascendingBtnPressed(_ sender: Any) {
        
        if ascendingSelected == false {
            
            setDescending(status: false)
            setAscending(status: true)
            ascendingSelected = true
            descendingSelected = false
            
        } else {
            
            setAscending(status: false)
            ascendingSelected = false
            
        }
        
    }
    
    @IBAction func descendingBtnPressed(_ sender: Any) {
        
        if descendingSelected == false {
            
            setAscending(status: false)
            setDescending(status: true)
            descendingSelected = true
            ascendingSelected = false
            
        } else {
            
            setDescending(status: false)
            descendingSelected = false
            
        }
        
    }
    
    func setAscending(status: Bool) {
        
        if status == true {
            requestPackage.addOption(name: "Sort", value: "Ascending")
            ascendingButton.image = NSImage(imageLiteralResourceName: "ascending_selected")
        } else {
            requestPackage.removeOption(name: "Sort")
            ascendingButton.image = NSImage(imageLiteralResourceName: "ascending")
        }
    }
    
    func setDescending(status: Bool) {
        
        if status == true {
            requestPackage.addOption(name: "Sort", value: "Descending")
            descendingButton.image = NSImage(imageLiteralResourceName: "descending_selected")
        } else {
            requestPackage.removeOption(name: "Sort")
            descendingButton.image = NSImage(imageLiteralResourceName: "descending")
        }
    }
    
    
    
}
