
//
//  NodePackage.swift
//  Proxy
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
