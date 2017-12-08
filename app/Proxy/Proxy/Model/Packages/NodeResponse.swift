//
//  NodeResponse.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class NodeResponse {
    
    private(set) var command = ""
    private(set) var payload = [String]()
    
    init(from data: Data) {
        
        guard let json = Serializer.json(from: data) as? [String:Any] else {
            print("Could not deserialize Node Response")
            return
        }
        
        guard let command = json["Command"] as? String else {
            print("Could not decode Command")
            return
        }
        
        guard let payload = json["Payload"] as? [String] else {
            print("Could not decode Payload")
            return
        }
        
        self.command = command
        self.payload = payload
        
    }
    
}
