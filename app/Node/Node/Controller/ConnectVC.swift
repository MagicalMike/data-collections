//
//  ViewController.swift
//  Node
//
//  Created by Mihai Petrenco on 11/29/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa
import Socket

class ConnectVC: NSViewController {

    //MARK: - Outlet declarations
    @IBOutlet weak var nameTextfield: CustomTextfield!
    @IBOutlet weak var addressTextfield: CustomTextfield!
    @IBOutlet weak var portTextfield: CustomTextfield!
    @IBOutlet weak var errorLabel: NSTextField!
    
    //MARK: - Variable declarations
    var tcpSocket: Socket?
    
    //MARK: - View lifecycle
    override func viewDidAppear() {
        setupWindow()
    }
    
    //MARK: - User action implementations
    @IBAction func connectBtnPressed(_ sender: Any) {
        
        guard let port = Int(portTextfield.stringValue) else {
            displayError(with: "Invalid port")
            return
        }
        
        Node.setName(with: nameTextfield.stringValue)
        Node.setAddress(with: addressTextfield.stringValue)
        Node.setPort(with: port)
        
        if Node.name.count == 0 || Node.name.first == " " {
            displayError(with: "Invalid name")
            return
        }
        
        if Node.address.count == 0 || Node.address.first == " " {
            displayError(with: "Invalid address")
            return
        }
        
        tcpConnect(address: Node.address, port: Node.port)
        
    }
    
    func displayError(with message: String) {
        errorLabel.isHidden = false
        errorLabel.stringValue = message
    }
    
    func tcpConnect(address: String, port: Int) {
        
        do {
            tcpSocket = try Socket.create(family: .inet, type: .stream, proto: .tcp)
            let identifier = NSStoryboardSegue.Identifier("NodeVC")
            performSegue(withIdentifier: identifier, sender: self)
        } catch {
            displayError(with: "Could not create node.")
            print("Error at function: \(#function)")
            print(error)
        }
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let destination = segue.destinationController as! NodeVC
        destination.tcpSocket = self.tcpSocket
        destination.previousVC = self
    }
    
    //MARK: - UI-Related
    func setupWindow() {
        let window = self.view.window
        window?.backgroundColor = #colorLiteral(red: 0.1180996193, green: 0.1180996193, blue: 0.1180996193, alpha: 1)
        window?.isMovableByWindowBackground = true
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.minSize = NSSize(width: 311, height: 400)
        window?.maxSize = NSSize(width: 311, height: 400)
    }
}

