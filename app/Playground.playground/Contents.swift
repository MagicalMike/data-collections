import Cocoa

func xml(from response: String, and payload: [String]) -> String {
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



let response = "Response"
let payload = ["Hello","My name is Jafar", "I come from afar", "Allahu Akbar!"]

let xmlString = xml(from: response, and: payload)
let validXMLString = xmlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

let xmlURL = URL(string: validXMLString!)



func process(string: String) {
    do {
        let xmlDocument = try XMLDocument(xmlString: string, options: .documentValidate)
        let rootNode = xmlDocument.rootElement()!
        let responseNode = rootNode.elements(forName: "response")
        
        let processNodes = rootNode.elements(forName: "payload")
        let valueNodes = processNodes.first?.elements(forName: "value")
        
        for value in valueNodes! {
            print(value.stringValue)
        }
        
    
        
        
    } catch {
        print(error)
    }
    
}

process(string: xmlString)





