//
//  ConnectionDataSource.swift
//  Node
//
//  Created by Mihai Petrenco on 12/1/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa

class ConnectionDataSource: NSObject, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return Node.connections.count
    }
    
}
