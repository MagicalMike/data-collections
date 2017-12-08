//
//  DiscoveryResponse.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation


class DiscoveryResponse {
    
    private(set) var address = ""
    private(set) var port = 0
    private(set) var connections = [[String:Any]]()
    
    init(from data: Data) {
        
        guard let json = Serializer.json(from: data) as? [String:Any] else {
            print("Could not deserialize Discovery Resposne")
            return
        }
        
        guard let address = json["Address"] as? String else {
            print("Could not decode Address")
            return
        }
        
        guard let port = json["Port"] as? Int else {
            print("Could not decode Port")
            return
        }
        
        guard let connections = json["Connections"] as? [[String:Any]] else {
            print("Could not decode Connections")
            return
        }
        
        self.address = address
        self.port = port
        self.connections = connections
        
    }
    
}
