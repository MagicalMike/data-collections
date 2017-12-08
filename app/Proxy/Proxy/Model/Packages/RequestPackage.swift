//
//  RequestPacket.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class RequestPackage {
    
    private(set) var command = ""
    private(set) var format = ""
    private(set) var options = [[String:Any]]()
    
    init(from data: Data) {
        
        guard let json = Serializer.json(from: data) as? [String:Any] else {
            print("Could not deserialize Data")
            return
        }
        
        guard let command = json["Command"] as? String else {
            print("Could not interpret Command")
            return
        }
        
        guard let format = json["Format"] as? String else {
            print("Could not interpret Format")
            return
        }
        
        guard let options = json["Options"] as? [[String:Any]] else {
            print("Could not interpret Options")
            return
        }
        
        self.command = command
        self.format = format
        self.options = options
        
    }
    
}
