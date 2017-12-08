//
//  MessagingVC.swift
//  Client
//
//  Created by Mihai Petrenco on 12/4/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa
import Socket

class MessagingVC: NSViewController {
    
    //MARK: - Outlet declarations
    @IBOutlet weak var tableVIew: NSTableView!
    @IBOutlet weak var sortButton: NSButton!
    @IBOutlet weak var filterButton: NSButton!
    @IBOutlet weak var filterTextfield: CustomTextfield!
    
    
    //MARK: - Variable declarations
    var tcpSocket: Socket!
    var requestPackage = RequestPackage()
    var responsePackage = ResponsePackage()
    
    var previousVC: ConnectVC!
    
    var filterSelected = false
    
    @IBOutlet weak var tableView: NSTableView!
    var tableviewDelegate = TableViewDelegate()
    var tableviewDataSource = TableViewDataSource()
    
    
    
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        tableView.delegate = tableviewDelegate
        tableView.dataSource = tableviewDataSource
    }
    
    override func viewDidAppear() {
        setupWindow()
        setupViews()
    }
    
    //MARK: - User actions
    @IBAction func sortBtnPressed(_ sender: Any) {
        
        let identifier = NSStoryboardSegue.Identifier("SortVC")
        performSegue(withIdentifier: identifier, sender: self)
        
    }
    
    
    @IBAction func filterBtnPressed(_ sender: Any) {
        
        if filterSelected == false {
            filterTextfield.isHidden = false
            filterSelected = true
        } else {
            filterTextfield.isHidden = true
            filterTextfield.stringValue = ""
            filterSelected = false
        }
        
    }
    
    @IBAction func formatBtnPressed(_ sender: Any) {
        
        let identifier = NSStoryboardSegue.Identifier("FormatVC")
        performSegue(withIdentifier: identifier, sender: self)
        
    }
    
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        requestPackage.setCommand(value: "GET")
        
        if filterSelected {
            requestPackage.addOption(name: "Filter", value: filterTextfield.stringValue)
        } else {
            requestPackage.removeOption(name: "Filter")
        }
        
        guard let data = Serializer.toData(from: requestPackage.toJSON()) else {
            print("Could not serialize Request Package")
            return
        }
        
        send(data: data)
        
    }
    
    func send(data: Data) {
        
        do {
            let _ = try tcpSocket.write(from: data)
            
            var receivedData = Data()
            let _ = try tcpSocket.read(into: &receivedData)
            
            self.read(data: receivedData)
            
        } catch {
            print(error)
        }
        
    }
    
    func read(data: Data) {
        
        if requestPackage.format == "JSON" {
            
            guard let json = Serializer.toJSON(from: data) as? [String:Any] else {
                print("Could not convert Data into JSON")
                return
            }
            
            guard let response = json["Command"] as? String else {
                print("Could not interpret Command")
                return
            }
            
            guard let payload = json["Payload"] as? [String] else {
                print("Coult not interpret Payload")
                return
            }
            
            responsePackage.setCommand(value: response)
            responsePackage.setPayload(value: payload)
            
            processResponse()
            
            print("JSON PARSED")
        }
        
        if requestPackage.format == "XML" {
            
            do {
                let xmlDocument = try XMLDocument(data: data, options: .documentValidate)
                let rootElement = xmlDocument.rootElement()
                let responseNode = rootElement!.elements(forName: "response")
                
                let response = responseNode.first!.stringValue!
                
                let processNodes = rootElement!.elements(forName: "payload")
                let valueNodes = processNodes.first?.elements(forName: "value")
                
                var payload = [String]()
                
                for value in valueNodes! {
                    payload.append(value.stringValue!)
                }

                
                responsePackage.setCommand(value: response)
                responsePackage.setPayload(value: payload)
                
                processResponse()
                
                print("XML PARSED")
                
            } catch {
                print(error)
            }
            
        }
        
        
    }
    
    func processResponse() {
        
        print(responsePackage.command)
        print(responsePackage.payload)
        
        tableviewDelegate.updateContents(with: responsePackage.payload)
        tableviewDataSource.updateRowCount(with: tableviewDelegate.getCount())
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController as? SortVC {
            destination.requestPackage = self.requestPackage
        }
        
        if let destination = segue.destinationController as? FormatVC {
            destination.requestPackage = self.requestPackage
        }
        
    }
    
    //MARK: - UI-Related
    func setupViews() {
        previousVC!.dismiss(self)
        previousVC.view.window?.close()
    }
    
    func setupWindow() {
        let window = self.view.window
        window?.backgroundColor = #colorLiteral(red: 0.1880131066, green: 0.1867424846, blue: 0.1867125928, alpha: 1)
        window?.isMovableByWindowBackground = true
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.minSize = NSSize(width: 531, height: 407)
        window?.maxSize = NSSize(width: 531, height: 407)
    }
    
}
