//
//  RequestPackage.swift
//  Client
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class RequestPackage {
    
    private(set) var command = ""
    private(set) var options = [[String:String]]()
    private(set) var format = "JSON"
    
    func setCommand(value: String) {
        self.command = value
    }
    
    func setFormat(value: String) {
        self.format = value
    }
    
    func addOption(name: String, value: String) {
        
        var index = 0
        while index < options.count {
            if options[index]["Name"] == name {
                options[index]["Value"] = value
                return
            }
            index += 1
        }
        
        var dict = [String:String]()
        dict["Name"] = name
        dict["Value"] = value
        
        self.options.append(dict)
        
    }
    
    func removeOption(name: String) {
        
        var index = 0
        while index < options.count {
            if options[index]["Name"] == name {
                options.remove(at: index)
                return
            }
            index += 1
        }
        
    }
    
    func toJSON() -> [String:Any] {
        
        var dict = [String:Any]()
        dict["Command"] = command
        dict["Format"] = format
        dict["Options"] = options
        
        return dict
    }
    
}
