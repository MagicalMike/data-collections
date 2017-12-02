//
//  Package.swift
//  Node
//
//  Created by Mihai Petrenco on 11/30/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class Package {
    
    private(set) var data = [String:Any]()
    
    init(with options: [String:Any]) {
        for (key,value) in options {
            data[key] = value
        }
    }
    
    func addOption(title: String, contents: Any) {
        data[title] = contents
    }
    
    func addConnections(from tuple: [(String,Int)]) {
        
        var array = [[String:Any]]()
        
        for element in tuple {
            var connection = [String:Any]()
            connection["Address"] = element.0
            connection["Port"] = element.1
            array.append(connection)
        }
        
        addOption(title: "Connections", contents: array)
    }
    
    func removeOption(with title: String) {
        data.removeValue(forKey: title)
    }

}
