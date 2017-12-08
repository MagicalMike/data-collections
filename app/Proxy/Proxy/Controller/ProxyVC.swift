//
//  ViewController.swift
//  Proxy
//
//  Created by Mihai Petrenco on 11/29/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa
import Socket

class ProxyVC: NSViewController {
    
    //MARK: Variable declarations
    var tcpListener: Socket!
    var udpListener: Socket!
    var udpBroadcaster: Socket!
    
    var tcpListening = true
    var udpListening = true
    
    var responsePackage = ResponsePackage()
    var previousVC: ConnectVC!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        
        self.initiate()
        
        DispatchQueue.global().async {
            while self.udpListening {
                self.udpListen()
            }
        }
        
        DispatchQueue.global().async {
            self.tcpListen()
        }
 
    }
    
    override func viewDidAppear() {
        self.setupWindow()
        self.setupViews()
    }
    
    //MARK: - Socket initiation
    func initiate() {
        do {
            tcpListener = try Socket.create(family: .inet, type: .stream, proto: .tcp)
            try tcpListener.listen(on: Proxy.tcpPort)
            
            udpListener = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            try udpListener.listen(on: Proxy.udpPort)
            
            udpBroadcaster = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            try udpBroadcaster?.udpBroadcast(enable: true)
        } catch {
           print(error)
        }
    }

    
    
    
    func tcpListen() {
        
        do {
            let socket = try tcpListener.acceptClientConnection()
            self.udpBroadcast()
            NodeCollection.process()
            
            while tcpListening {
                self.tcpRead(with: socket)
            }
            
        } catch {
            print(error)
        }
        
    }
    
    
    func tcpRead(with socket: Socket) {
        
        do {
            
            var receivedData = Data()
            let _ = try socket.read(into: &receivedData)
            
            let request = RequestPackage(from: receivedData)
            
            //COLLECT PAYLOAD
            var result = [String]()
            for node in NodeCollection.nodes {
                result.append(contentsOf: self.obtainData(from: node)!)
            }
            
            //PROCESS PAYLOAD
            let sorted = processResponse(with: request, and: result)
            
            //RETURN RESPONSE TO CLIENT
            let response = ResponsePackage()
            response.setCommand(value: "Response")
            response.setPayload(value: sorted)
            
            print(request.format)
            
            guard let data = generateData(response: response, using: socket, with: request.format) else {
                print("Could not generate Data from Response")
                return
            }
            
            let _  = try socket.write(from: data)
            
        } catch {
            print(error)
        }
        
    }
    
    
    func obtainData(from node: Node) -> [String]? {
        
        do {
            
            let socket = try Socket.create()
            try socket.connect(to: node.address, port: Int32(node.port))
            
            let nodeRequest = NodeRequest(command: "GET", isMaven: node.isMaven)
            guard let data = Serializer.data(from: nodeRequest.toJSON()) else {
                print("ERROR 2")
                return nil
            }
            
            let _ = try socket.write(from: data)
            
            var responseData = Data()
            let _ = try socket.read(into: &responseData)
            
            let response = NodeResponse(from: responseData)
            
            socket.close()
            
            return response.payload
        } catch {
            print(error)
        }
        return nil
    }
    
    func processResponse(with request: RequestPackage, and payload: [String]) -> [String] {
        
        var result = payload
        
        for option in request.options {
            
            print(option)
            
            if option["Name"] as? String == "Sort" {
                
                if option["Value"] as? String == "Ascending" {
                    result = result.sorted {$1 > $0}
                }
                
                if option["Value"] as? String == "Descending" {
                    result = result.sorted {$0 > $1}
                }
                
            }
            
            if option["Name"] as? String == "Filter" {
                
                var temp = [String]()
                
                for element in result {
                    let value = option["Value"] as! String
                    if element.contains(value) {
                        temp.append(element)
                    }
                }
                result = temp
            }
        }
        
        return result
    }
    
    func generateData(response: ResponsePackage, using socket: Socket, with format: String) -> Data? {
        
        if format == "JSON" {
            guard let data = Serializer.data(from: response.toJSON()) else {
                print("ERROR")
                return nil
            }
            return data
        }
        
        if format == "XML" {
            let xmlString = Serializer.xml(from: response.command, and: response.payload)
            print(xmlString)

            let xmlData = xmlString.data(using: .utf8)
            return xmlData
        }
        return nil
    }
    

    func udpListen() {
        
        do {
            var receivedData = Data()
            let _ = try udpListener.listen(forMessage: &receivedData, on: Proxy.udpPort)
            
            let discoveryResponse = DiscoveryResponse(from: receivedData)
            let node = Node(with: discoveryResponse)
            NodeCollection.addNode(node: node)
            
        } catch {
            print(error)
        }
        
    }
    
    func udpBroadcast() {
        
        do {
            let discoveryRequest = DiscoveryRequest(address: Proxy.udpAddress, port: Proxy.udpPort)
            
            guard let data = Serializer.data(from: discoveryRequest.toJSON()) else {
                print("Error while serializing Discovery Request")
                return
            }

            try udpBroadcaster.write(from: data, to: Proxy.broadcastConnection!)
            
        } catch {
            print(error)
        }
        
    }
    
    //MARK: - UI-Related
    func setupWindow() {
        let window = self.view.window
        window?.backgroundColor = #colorLiteral(red: 0.1785731058, green: 0.1814083558, blue: 0.2371275907, alpha: 1)
        window?.isMovableByWindowBackground = true
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.minSize = NSSize(width: 311, height: 400)
        window?.maxSize = NSSize(width: 311, height: 400)
    }
    
    func setupViews() {
        previousVC!.dismiss(self)
        previousVC.view.window?.close()
    }
    
}
    
    
