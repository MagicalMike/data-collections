//
//  Validator.swift
//  Client
//
//  Created by Mihai Petrenco on 12/4/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class Validator {
    
    static func validateIP(value: String) -> String? {
        
        guard let firstSequence = checkRange(of: value) else {
            return nil
        }
        
        guard let secondSequence = checkRange(of: firstSequence) else {
            return nil
        }
        
        guard let thirdSequence = checkRange(of: secondSequence) else {
            return nil
        }
        
        guard let _ = checkRange(of: thirdSequence + ".") else {
            return nil
        }
        
        return value
    }
    
    static func validatePort(value: String) -> Int? {
        
        guard let port = Int(value) else {
            return nil
        }
        
        if port > 0 && port < 65535 {
            return port
        }
        return nil
    }
    
    
    static func checkRange(of string: String) -> String? {
        
        var temp = string
        
        guard let endPoint = temp.index(of: ".") else {
            return nil
        }
        
        let range = temp.startIndex..<endPoint
        let sequence = temp[range]
        
        guard let value = Int(sequence) else {
            return nil
        }
        
        if value < 0 || value > 255 {
            return nil
        }
        
        temp = temp.replacingCharacters(in: range, with: "")
        
        guard let dot = temp.first else {
            return nil
        }
        
        if dot != "." {
            return nil
        }
        
        let _ = temp.remove(at: temp.startIndex)
        return temp
    }
    
}
