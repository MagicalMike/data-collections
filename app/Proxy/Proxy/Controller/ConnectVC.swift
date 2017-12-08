//
//  ConnectVC.swift
//  Proxy
//
//  Created by Mihai Petrenco on 12/4/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa
import Socket

class ConnectVC: NSViewController {
    
    //MARK: - Outlet declarations
    
    @IBOutlet weak var errorLabel: NSTextField!
    
    @IBOutlet weak var tcpAddress: NSTextField!
    @IBOutlet weak var tcpPort: NSTextField!
    
    @IBOutlet weak var udpAddress: NSTextField!
    @IBOutlet weak var udpPort: NSTextField!
    
    @IBOutlet weak var broadcastAddress: NSTextField!
    @IBOutlet weak var broadcastPort: NSTextField!
    
    override func viewDidAppear() {
        self.setupWindow()
    }
    
    //MARK: - User actions
    @IBAction func connectBtnPressed(_ sender: Any) {
        
        guard let tcpAddress = Validator.validateIP(value: tcpAddress.stringValue) else {
            displayError(with: "Invalid TCP address")
            return
        }
        
        guard let tcpPort = Validator.validatePort(value: tcpPort.stringValue) else {
            displayError(with: "Invalid TCP port")
            return
        }
        
        guard let udpAddress = Validator.validateIP(value: udpAddress.stringValue) else {
            displayError(with: "Invalid UDP address")
            return
        }
        
        guard let udpPort = Validator.validatePort(value: udpPort.stringValue) else {
            displayError(with: "Invalid UDP port")
            return
        }
        
        guard let broadcastIP = Validator.validateIP(value: broadcastAddress.stringValue) else {
            displayError(with: "Invalid broadcast address")
            return
        }
        
        guard let broadcastPort = Validator.validatePort(value: broadcastPort.stringValue) else {
            displayError(with: "Invalid broadcast port")
            return
        }
        
        Proxy.setupTCP(address: tcpAddress, port: tcpPort)
        Proxy.setupUDP(address: udpAddress, port: udpPort)
        Proxy.setupBroadcast(address: broadcastIP, port: broadcastPort)
        
        let identifier = NSStoryboardSegue.Identifier("ProxyVC")
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    //MARK: - Segue-related functionalities
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        let destination = segue.destinationController as! ProxyVC
        destination.previousVC = self
        
    }
    
    //MARK: - UI-related functionalities
    func displayError(with message: String) {
        errorLabel.isHidden = false
        errorLabel.stringValue = message
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
    
}
