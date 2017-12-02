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
    static func generateData(from obj: Any) -> Data?{
        
        do {
            print(JSONSerialization.isValidJSONObject(obj))
            let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return data
        } catch {
            print("Error at function: \(#function)")
            print(error)
        }
        
        return nil
    }
    
    //Generate a valid JSON from a Data object
    static func generateJSON(from data: Data) -> Any? {
        
        do {
            print(JSONSerialization.isValidJSONObject(data))
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json
        } catch {
            print("Error at function: \(#function)")
            print(error)
        }
        
        return nil
    }
}
