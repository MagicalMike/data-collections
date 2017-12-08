//
//  Proxy.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/2/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Foundation
import Socket

class Proxy {
    
    private(set) static var tcpAddress = "127.0.0.1"
    private(set) static var tcpPort: Int = 9000
    
    private(set) static var udpAddress = "127.0.0.1"
    private(set) static var udpPort = 9991
    
    private(set) static var broadcastIP = "255.255.255.255"
    private(set) static var broadcastPort: Int = 9999
    
    private(set) static var tcpConnection = Socket.createAddress(for: tcpAddress, on: Int32(tcpPort))!
    private(set) static var udpConnection = Socket.createAddress(for: udpAddress, on: Int32(udpPort))!
    private(set) static var broadcastConnection = Socket.createAddress(for: broadcastIP, on: Int32(broadcastPort))
    
    static func setupTCP(address: String, port: Int) {
        self.tcpAddress = address
        self.tcpPort = port
        self.tcpConnection = Socket.createAddress(for: address, on: Int32(port))!
    }
    
    static func setupUDP(address: String, port: Int) {
        self.udpAddress = address
        self.udpPort = port
        self.udpConnection = Socket.createAddress(for: address, on: Int32(port))!
    }
    
    static func setupBroadcast(address: String, port: Int) {
        self.broadcastIP = address
        self.broadcastPort = port
        self.broadcastConnection = Socket.createAddress(for: address, on: Int32(port))!
    }
    
    
}
