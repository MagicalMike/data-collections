//
//  NodeRequest.swift
//  Node
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class NodeRequest {
    
    private(set) var command = ""
    private(set) var isMaven = false
    
    init(command: String, isMaven: Bool) {
        self.command = command
        self.isMaven = isMaven
    }
    
    init(from data: Data) {
        
        guard let json = Serializer.json(from: data) else {
            print("Could not deserialize Node Request")
            return
        }
        
        guard let command = json["Command"] as? String else {
            print("Could not decode Command")
            return
        }
        
        guard let maven = json["Maven"] as? String else {
            print("Could not decode Maven")
            return
        }
        
        self.command = command
        
        if maven == "True" {
            self.isMaven = true
        } else {
            self.isMaven = false
        }
        
    }
    
    func toJSON() -> [String:Any] {
        
        var dict = [String:Any]()
        
        dict["Command"] = command
        
        if isMaven {
            dict["Maven"] = "True"
        } else {
            dict["Maven"] = "False"
        }
        
        return dict
    }
    
}
