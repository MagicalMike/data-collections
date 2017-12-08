//
//  NodeVC.swift
//  Node
//
//  Created by Mihai Petrenco on 11/29/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa
import Socket

class NodeVC: NSViewController {
    
    //MARK: - Outlet declarations
    @IBOutlet weak var nameTextfield: NSTextField!
    @IBOutlet weak var addressTextfield: NSTextField!
    @IBOutlet weak var portTextfield: NSTextField!
    
    
    
    //MARK: - Variable declarations
    var previousVC: ConnectVC!
    
    var tcpSocket: Socket?
    var udpSocket: Socket?
    
    var tcpListening = true
    var udpListening = true
    
    
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        
        initiate()
        
        DispatchQueue.global().async {
            while self.udpListening {
                self.udpListen()
            }
        }
        
        DispatchQueue.global().async {
            while self.tcpListening {
                self.tcpListen()
            }
        }
        
        
    }
    
    override func viewDidAppear() {
        setupViews()
        setupWindow()
    }
    
    
    func initiate() {
        do {
            tcpSocket = try Socket.create(family: .inet, type: .stream, proto: .tcp)
            try tcpSocket?.listen(on: Node.port)
            udpSocket = try Socket.create(family: .inet, type: .datagram, proto: .udp)
        } catch {
            print(error)
        }
    }
   
    
    func udpListen() {
        
        do {
            var receivedData = Data()
            let _ = try udpSocket?.listen(forMessage: &receivedData, on: 9999)
            
            let discoveryRequest = DiscoveryRequest(from: receivedData)
            
            let discoveryResponse = DiscoveryResponse()
            discoveryResponse.setAddress(Node.address)
            discoveryResponse.setPort(Node.port)
            discoveryResponse.setConnections(Node.connections)
            
            guard let data = Serializer.data(from: discoveryResponse.toJSON()) else {
                print("Could not serialize Discovery Response package")
                return
            }
            
            let address = Socket.createAddress(for: discoveryRequest.address, on: Int32(discoveryRequest.port))
            let _ = try udpSocket?.write(from: data, to: address!)
            
        } catch {
            print(error)
        }
        
    }
    
    func tcpListen() {
        
        do {
            let client = try tcpSocket?.acceptClientConnection()
            print("CONNECTED")
            self.tcpRead(from: client!)
            
        } catch {
            print(error)
        }
        
    }
    
    func tcpRead(from socket: Socket) {
        do {
            var receivedData = Data()
            let _ = try socket.read(into: &receivedData)
            
            let nodeRequest = NodeRequest(from: receivedData)
            print(nodeRequest.command)
            print(nodeRequest.isMaven)
            self.process(request: nodeRequest, for: socket)
            
        } catch {
            print(error)
        }
    }
    
    func process(request: NodeRequest, for socket: Socket) {
        
        var payload = [Node.payload]
        
        if request.isMaven {
            for connection in Node.connections {
                DispatchQueue.global().async {
                    payload.append(contentsOf: self.obtainData(from: connection)!)
                }
            }
        }
        
        do {
            let nodeResponse = NodeResponse(command: "Response", payload: payload)
            
            guard let data = Serializer.data(from: nodeResponse.toJSON()) else {
                print("Could not serialize Node Response")
                return
            }
            
            let _ = try socket.write(from: data)
        } catch {
            print(error)
        }
        
    }
    
    func obtainData(from connection: (String,Int)) -> [String]? {
        
        do {
            
            let socket = try Socket.create()
            try socket.connect(to: connection.0, port: Int32(connection.1))
            
            let nodeRequest = NodeRequest(command: "GET", isMaven: false)
            guard let data = Serializer.data(from: nodeRequest.toJSON()) else {
                print("ERROR 2")
                return nil
            }
            
            print("EXECUTED")
            
            let _ = try socket.write(from: data)
            
            var responseData = Data()
            let _ = try socket.read(into: &responseData)
            
            let response = NodeResponse(from: responseData)
            socket.close()
            
            print(response.payload)
            
            return response.payload
        } catch {
            print(error)
        }
        return nil
    }
    
    //MARK: - UI-Related
    func setupViews() {
        previousVC!.dismiss(self)
        previousVC.view.window?.close()
        
        nameTextfield.stringValue = Node.name
        addressTextfield.stringValue = Node.address
        portTextfield.stringValue = "Connected on port: \(Node.port)"
    }
    
    func setupWindow() {
        let window = self.view.window
        window?.backgroundColor = #colorLiteral(red: 0.1180996193, green: 0.1180996193, blue: 0.1180996193, alpha: 1)
        window?.isMovableByWindowBackground = true
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.minSize = NSSize(width: 253, height: 191)
        window?.maxSize = NSSize(width: 253, height: 191)
    }
}
