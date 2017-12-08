//
//  Node.swift
//  Node
//
//  Created by Mihai Petrenco on 12/1/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class Node {
    
    //MARK: - Variable declarations
    private(set) static var name = ""
    private(set) static var address = ""
    private(set) static var port = 0
    private(set) static var payload = ""
    private(set) static var connections = [(String,Int)]()
    
    
    //MARK: - Setters
    static func setName(with contents: String) {
        self.name = contents;
    }
    
    static func setAddress(with contents: String) {
        self.address = contents;
    }
    
    static func setPort(with number: Int) {
        self.port = number;
    }
    
    static func setPayload(with contents: String) {
        self.payload = contents;
    }
    
    
    //MARK: - Connection functionalities
    static func addConnection(address: String, port: Int) {
        for (first,second) in connections {
            if first == address && second == port {
                return
            }
            
            if address == Node.address && port == Node.port {
                return
            }
        }
        connections.append((address,port))
    }
    
    static func removeConnection(address: String, port: Int) {
        var currentIndex = 0
        for (first, second) in connections {
            if first == address && second == port {
                connections.remove(at: currentIndex)
                return
            }
            currentIndex += 1
        }
    }
}
