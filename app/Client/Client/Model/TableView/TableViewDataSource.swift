//
//  TableViewDataSource.swift
//  Client
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa

class TableViewDataSource: NSObject, NSTableViewDataSource {
    
    private(set) var rowCount = 0
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return rowCount
    }
    
    func updateRowCount(with number: Int) {
        self.rowCount = number
    }
    
}
