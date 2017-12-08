//
//  CustomTextfield.swift
//  Node
//
//  Created by Mihai Petrenco on 11/29/17.
//  Copyright © 2017 Limitless. All rights reserved.
//

import Cocoa

class CustomTextfield: NSTextField {
    
    override func awakeFromNib() {
        
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        wantsLayer = true
        layer?.cornerRadius = 5.0
        isBordered = false
        
        if placeholderString == nil {
            placeholderString = ""
        }
        
        let attributedString = NSMutableAttributedString(string: placeholderString!)
        let range = NSString(string: placeholderString!).range(of: placeholderString!)
        let font = NSFont(name: "Avenir", size: 18)
        
        attributedString.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), range: range)
        attributedString.addAttribute(.font, value: font!, range: range)
        
        placeholderAttributedString = attributedString
        
    }
    
}
