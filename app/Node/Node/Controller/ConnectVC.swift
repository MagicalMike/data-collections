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
    
    //MARK: - View lifecycle
    override func viewDidAppear() {
        setupWindow()
    }
    
    //MARK: - User action implementations
    @IBAction func connectBtnPressed(_ sender: Any) {
        
        guard let address = Validator.validateIP(value: addressTextfield.stringValue) else {
            displayError(with: "Invalid address")
            return
        }
        
        guard let port = Validator.validatePort(value: portTextfield.stringValue) else {
            displayError(with: "Invalid port")
            return
        }
        
        if nameTextfield.stringValue.count == 0 || nameTextfield.stringValue.first == " " {
            displayError(with: "Invalid name")
            return
        }
        
        Node.setName(with: nameTextfield.stringValue)
        Node.setAddress(with: address)
        Node.setPort(with: port)
        
        let identifier = NSStoryboardSegue.Identifier("NodeVC")
        performSegue(withIdentifier: identifier, sender: self)
        
    }
    
    func displayError(with message: String) {
        errorLabel.isHidden = false
        errorLabel.stringValue = message
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let destination = segue.destinationController as! NodeVC
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

