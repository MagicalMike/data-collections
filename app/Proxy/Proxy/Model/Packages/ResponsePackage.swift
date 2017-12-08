//
//  ResponsePackage.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class ResponsePackage {
    
    private(set) var command = ""
    private(set) var payload = [String]()
    
    func setCommand(value: String) {
        self.command = value
    }
    
    func setPayload(value: [String]) {
        self.payload = value
    }
    
    func toJSON() -> [String:Any] {
        var dict = [String:Any]()
        
        dict["Command"] = command
        dict["Payload"] = payload
        
        return dict
    }
    
}
