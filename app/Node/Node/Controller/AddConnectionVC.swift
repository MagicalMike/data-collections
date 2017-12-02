//
//  AddConnectionVC.swift
//  Node
//
//  Created by Mihai Petrenco on 12/1/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa

class AddConnectionVC: NSViewController {
    
    @IBOutlet weak var addressTextfield: CustomTextfield!
    @IBOutlet weak var portTextfield: CustomTextfield!
    
    var tableView: NSTableView?
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        
        let address = addressTextfield.stringValue
        
        guard let port = Int(portTextfield.stringValue) else {
            return
        }
        
        Node.addConnection(address: address, port: port)
        tableView?.reloadData()
        self.dismiss(self)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(self)
    }
}
