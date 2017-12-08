//
//  ViewController.swift
//  Client
//
//  Created by Mihai Petrenco on 11/29/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa
import Socket

class ConnectVC: NSViewController {
    
    //MARK: - Outlet declarations
    @IBOutlet weak var ipTextfield: CustomTextfield!
    @IBOutlet weak var portTextfield: CustomTextfield!
    @IBOutlet weak var errorLabel: NSTextField!
    
    
    //MARK: - Variable declarations
    private var tcpSocket: Socket?
    
    //MARK: - View lifecycle
    override func viewDidAppear() {
        setupWindow()
    }
    
    
    //MARK: - User actions
    @IBAction func connectBtnPressed(_ sender: Any) {
        
        guard let ip = Validator.validateIP(value: ipTextfield.stringValue) else {
            displayError(with: "Invalid IP address")
            return
        }
        
        guard let port = Validator.validatePort(value: portTextfield.stringValue) else {
            displayError(with: "Invalid port number")
            return
        }

        if connect(address: ip, port: port) {
            let identifier = NSStoryboardSegue.Identifier("MessagingVC")
            performSegue(withIdentifier: identifier, sender: self)
        }
       
    }
    
    
    //MARK: - Connection functionality
    func connect(address: String, port: Int) -> Bool {
        
        do {
            tcpSocket = try Socket.create(family: .inet, type: .stream, proto: .tcp)
            try tcpSocket?.connect(to: address, port: Int32(port), timeout: 10)
            return true
        } catch {
            displayError(with: "Could not initialize socket")
            print("Error at function: \(#function)")
            print(error)
        }
        return false
    }
    
    //MARK: - Segue-related functionalities
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let destination = segue.destinationController as! MessagingVC
        destination.tcpSocket = self.tcpSocket
        destination.previousVC = self
    }
    
    //MARK: - UI-Related
    func setupWindow() {
        let window = self.view.window
        window?.backgroundColor = #colorLiteral(red: 0.1880131066, green: 0.1867424846, blue: 0.1867125928, alpha: 1)
        window?.isMovableByWindowBackground = true
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.minSize = NSSize(width: 240, height: 314)
        window?.maxSize = NSSize(width: 240, height: 314)
    }
    
    func displayError(with message: String) {
        errorLabel.isHidden = false
        errorLabel.stringValue = message
    }

}

