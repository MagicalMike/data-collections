//
//  PayloadVC.swift
//  Node
//
//  Created by Mihai Petrenco on 11/29/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa
import Socket

class PayloadVC: NSViewController {
    
    @IBOutlet weak var payloadTextfield: CustomTextfield!
    @IBOutlet weak var payloadLabel: NSTextField!
    
    override func viewDidLoad() {
        payloadLabel.stringValue = Node.payload
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        
        let contents = payloadTextfield.stringValue
        
        if contents.count > 0 && contents.first != " " {
            Node.setPayload(with: contents)
            self.dismiss(self)
        }
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(self)
    }
    
    
}
