//
//  ViewController.swift
//  Proxy
//
//  Created by Mihai Petrenco on 11/29/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa
import Socket

class ViewController: NSViewController {

    @IBOutlet weak var ipTextfield: NSTextField!
    @IBOutlet weak var portTextfield: NSTextField!
    
    @IBOutlet weak var messageTextfield: NSTextField!
    
    @IBAction func broadcast(_ sender: Any) {
        
        let IPAddress = ipTextfield.stringValue
        let port = Int32(portTextfield.stringValue)
        
        do {
            let socket = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            try socket.udpBroadcast(enable: true)
            
            let address = Socket.createAddress(for: IPAddress, on: port!)
            try socket.write(from: messageTextfield.stringValue, to: address!)
            
            var resultData = Data()
            try socket.readDatagram(into: &resultData)
            let result = String(data: resultData, encoding: .utf8)
            print(result!)
            
        } catch {
            print("Error at function:   \(#function)")
            print(error)
        }
        
        
        
    }
    
}

