//
//  DiscoveryRequest.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/6/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class DiscoveryRequest {
    
    private(set) var address = ""
    private(set) var port = 0
    
    init(address: String, port:Int) {
        self.address = address
        self.port = port
    }
    
    func toJSON() -> [String:Any] {
        
        var dict = [String:Any]()
        
        dict["Address"] = address
        dict["Port"] = port
        
        return dict
    }
    
}

