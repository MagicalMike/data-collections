//: Playground - noun: a place where people can play

import Cocoa

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
    
    func removeOption(with title: String) {
        data.removeValue(forKey: title)
    }
    
}

let json = Package(with: ["Address":"127.0.0.1","Port":9001])
JSONSerialization.isValidJSONObject(json.data)



