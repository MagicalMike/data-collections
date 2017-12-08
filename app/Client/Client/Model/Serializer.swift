//
//  Serializer.swift
//  Client
//
//  Created by Mihai Petrenco on 12/4/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class Serializer {
    
    static func toData(from json: Any) -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    static func validate(json: Any) -> Bool {
        return JSONSerialization.isValidJSONObject(json)
    }
    
    static func toJSON(from data: Data) -> Any? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            return json
        } catch {
            print(error)
        }
        return nil
    }

}
