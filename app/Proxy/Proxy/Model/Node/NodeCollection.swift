//
//  NodeCollection.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/2/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class NodeCollection {
    
    private(set) static var nodes = [Node]()
    
    static func addNode(node: Node) {
        nodes.append(node)
    }
    
    static func removeNode(address: String, port: Int) {
        
        var index = 0
        for node in nodes {
            if node.address == address && node.port == port {
                nodes.remove(at: index)
            }
            index += 1
        }
        
    }
    
    static func process() {
        
        guard let first = nodes.first else {
            print("Cannot process empty collection")
            return
        }
        
        var maven = first
        
        for node in nodes {
            if node.connections.count > maven.connections.count {
                maven = node
            }
        }
        
        for connection in maven.connections {
            removeNode(address: connection["Address"] as! String, port: connection["Port"] as! Int)
        }
        
    }
    
}
