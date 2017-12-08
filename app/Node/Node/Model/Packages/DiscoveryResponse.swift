//
//  DiscoveryResponse.swift
//  Node
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class DiscoveryResponse {
    
    private(set) var address = ""
    private(set) var port = 0
    private(set) var connections = [[String:Any]]()
    
    func setAddress(_ value: String) {
        self.address = value
    }
    
    func setPort(_ value: Int) {
        self.port = value
    }
    
    func setConnections(_ value: [(first: String, second: Int)]) {
        for element in value {
            var dict = [String:Any]()
            dict["Address"] = element.first
            dict["Port"] = element.second
            connections.append(dict)
        }
    }
    
    func toJSON() -> [String:Any] {
        var dict = [String:Any]()
        
        dict["Address"] = address
        dict["Port"] = port
        dict["Connections"] = connections
        
        return dict
    }
    
}
