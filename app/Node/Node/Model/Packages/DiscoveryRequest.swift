//
//  DiscoveryRequest.swift
//  Node
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class DiscoveryRequest {
    private(set) var address = ""
    private(set) var port = 0
    
    init(from data: Data) {
        
        guard let json = Serializer.json(from: data) else {
            print("Could not deserialize Discovery Request package")
            return
        }
        
        guard let address = json["Address"] as? String else {
            print("Could not decode JSON Address")
            return
        }
        
        guard let port = json["Port"] as? Int else {
            print("Could not decode JSON Port")
            return
        }
        
        self.address = address
        self.port = port
        
    }
}


