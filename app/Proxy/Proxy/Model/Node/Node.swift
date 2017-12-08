//
//  Node.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/2/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class Node {
    
    private(set) var address: String
    private(set) var port: Int
    private(set) var connections = [[String:Any]]()
    private(set) var isMaven = false
    
    init(address: String, port: Int, connections: [[String:Any]]) {
        self.address = address
        self.port = port
        self.connections = connections
    }
    
    init(with response: DiscoveryResponse) {
        self.address = response.address
        self.port = response.port
        self.connections = response.connections
    }
    
    func setMaven(status: Bool) {
        self.isMaven = status
    }
    
}
