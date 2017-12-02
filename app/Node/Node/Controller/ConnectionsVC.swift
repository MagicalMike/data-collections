//
//  ConnectionsVC.swift
//  Node
//
//  Created by Mihai Petrenco on 11/29/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa
import Socket

class ConnectionsVC: NSViewController {
    
    @IBOutlet weak var connectionTableview: NSTableView!
    
    let delegate = ConnectionDelegate()
    let dataSource = ConnectionDataSource()
    
    override func viewDidLoad() {
        connectionTableview.delegate = delegate
        connectionTableview.dataSource = dataSource
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        let identifier = NSStoryboardSegue.Identifier("AddConnectionVC")
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    @IBAction func removeBtnPressed(_ sender: Any) {
        let identifier = NSStoryboardSegue.Identifier("RemoveConnectionVC")
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController as? AddConnectionVC {
            destination.tableView = self.connectionTableview
        }
        
        if let destination = segue.destinationController as? RemoveConnectionVC {
            destination.tableView = self.connectionTableview
        }
    }
    
}
