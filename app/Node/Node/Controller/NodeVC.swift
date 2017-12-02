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
    
    let udpPort = 9999
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        udpSocket = try! Socket.create(family: .inet, type: .datagram, proto: .udp)
        udpInitiate()
    }
    
    override func viewDidAppear() {
        setupViews()
        setupWindow()
    }
    
    //MARK: - TCP functionalities
    func tcpInitiate() {
        
    }
    
    func tcpListen() {
        
        do {
            try tcpSocket?.listen(on: Node.port)
            let proxy = try tcpSocket?.acceptClientConnection()
            
            tcpRead(from: proxy!)
            
        } catch {
            print("Error at function: \(#function)")
            print(error)
        }
        
    }
    
    func tcpRead(from socket: Socket) {
        var tcpReceiver = Data()
        
        do {
            let result = try socket.read(into: &tcpReceiver)
            print(result)
            print(tcpReceiver)
            
        } catch {
            print("Error at function: \(#function)")
            print(error)
        }
        
        
        
    }
    
    
    //MARK: - UDP functionalities
    func udpInitiate() {
        DispatchQueue.global().async {
            while self.udpListening == true {
                self.udpListen()
            }
        }
    }
    
    func udpListen() {
        
        var udpReceiver = Data()
        
        do {
            let result = try self.udpSocket!.listen(forMessage: &udpReceiver, on: self.udpPort)
            let package = Package(with: ["Address":Node.address, "Port":Node.port])
            package.addConnections(from: Node.connections)
            
            if let data = Serializer.generateData(from: package.data) {
               try udpSocket?.write(from: data, to: result.address!)
            }
            
        } catch {
            print("Error at function: \(#function)")
            print(error)
        }
        
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
