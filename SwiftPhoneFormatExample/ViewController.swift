//
//  ViewController.swift
//  SwiftPhoneFormatExample
//
//  Created by Seth on 7/11/18.
//  Copyright © 2018 aii. All rights reserved.
//

import UIKit
import SwiftPhoneFormat

class ViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberField: UITextField!
    
    var formatter = PhoneFormatter(rulesets: PNFormatRuleset.usParethesis())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberField.becomeFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == phoneNumberField, let text = textField.text {
            
            // get current text + new character being entered
            var newStr = text + string
            
            // check if this is a backspace
            let isDeleting = (range.length > 0) && string.isEmpty
            if isDeleting == true {
                // trim last char for correct validation
                newStr.remove(at: newStr.index(before: newStr.endIndex))
            }
            
            // strip non-numeric characters
            let numberString = newStr.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
            // 11 character limit
            if numberString.count > 11 {
                return false
            }
            
            // don't update the field if formatting hasn't changed
            let formatted = formatter.format(number: numberString)
            if newStr != formatted {
                phoneNumberField.text = formatted
                return false
            }
        }
        
        return true
    }
    
}
