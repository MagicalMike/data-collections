//
//  Serializer.swift
//  Node
//
//  Created by Mihai Petrenco on 11/30/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class Serializer {
    
    //Generates a Data object from a valid JSON
    static func data(from obj: [String:Any]) -> Data?{
        
        do {
            let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return data
        } catch {
            print("Error at function: \(#function)")
            print(error)
        }
        
        return nil
    }
    
    //Generate a valid JSON from a Data object
    static func json(from data: Data) -> [String:Any]? {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json as? [String:Any]
        } catch {
            print("Error at function: \(#function)")
            print(error)
        }
        
        return nil
    }
}
