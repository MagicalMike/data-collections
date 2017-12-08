//
//  Serializer.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/2/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation

class Serializer {
    
    static func data(from obj: [String:Any]) -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    static func json(from data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch {
            print(error)
        }
        return nil
    }
    
    static func xml(from response: String, and payload: [String]) -> String {
        let xmlRoot = XMLElement(name: "xml")
        let xmlDocument = XMLDocument(rootElement: xmlRoot)
        
        let responseNode = XMLElement(name: "response", stringValue: response)
        xmlRoot.addChild(responseNode)
        
        let payloadNode = XMLElement(name: "payload")
        xmlRoot.addChild(payloadNode)
        
        for element in payload {
            let xmlElement = XMLElement(name: "value", stringValue: element)
            payloadNode.addChild(xmlElement)
        }
        
        return xmlDocument.xmlString
    }
    
}
