//
//  ConnectionDelegate.swift
//  Node
//
//  Created by Mihai Petrenco on 12/1/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa

class ConnectionDelegate: NSObject, NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        
        if tableColumn?.identifier.rawValue == "IPAddress" {
            cell.textField?.stringValue = Node.connections[row].0
        }
        
        if tableColumn?.identifier.rawValue == "PortNumber" {
            cell.textField?.stringValue = String(Node.connections[row].1)
        }
        
        return cell
    }
    
}

