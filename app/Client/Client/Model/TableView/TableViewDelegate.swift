//
//  TableViewDelegate.swift
//  Client
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa

class TableViewDelegate: NSObject, NSTableViewDelegate {
    
    private(set) var contents = [String]()
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
        cell.textField?.stringValue = contents[row]
        return cell
    }
    
    func updateContents(with payload: [String]) {
        self.contents += payload
    }
    
    func getCount() -> Int {
        return contents.count
    }
    
}
