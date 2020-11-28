//
//  AppBaseViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 07/11/20.
//

import Foundation
import UIKit

class ValidatorService {
    static func highlightErrorOn(_ textField: UITextField?) {
        textField?.becomeFirstResponder()
        textField?.layer.borderColor = UIColor.red.cgColor
        textField?.layer.borderWidth = 1
    }
    
    static func clearErrorsOn(_ textField: UITextField?) {
        textField?.layer.borderColor = .none
        textField?.layer.borderWidth = 0.0
    }
    
    static func getNormalizedData(_ textField: UITextField?) -> String {
        if let textValue = textField?.text {
            return textValue.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return ""
    }
    
    static func isValid(_ value: String, condition: (_ field: String) -> Bool, failure: () -> Void) -> Bool {
        if condition(value) {
            return true
        } else {
            failure()
            return false
        }
    }
    
    static func isEmailValid(_ emailTextField: UITextField?) -> Bool {
        var result = false
        let email = getNormalizedData(emailTextField)
        
        if ValidatorService.isValid(email, condition: { !$0.isEmpty }, failure: {
            ValidatorService.highlightErrorOn(emailTextField)
        }) {
            ValidatorService.clearErrorsOn(emailTextField)
            result = true
        }
        
        return result
    }
    
    static func isPasswordValid(_ passwordTextField: UITextField?) -> Bool {
        var result = false
        let password = getNormalizedData(passwordTextField)
        
        if ValidatorService.isValid(password, condition: { $0.count >= 6 }, failure: {
            ValidatorService.highlightErrorOn(passwordTextField)
        }) {
            ValidatorService.clearErrorsOn(passwordTextField)
            result = true
        }
        
        return result
    }
    
    static func isNameValid(_ nameTextField: UITextField?) -> Bool {
        var result = false
        let name = getNormalizedData(nameTextField)
        
        if ValidatorService.isValid(name, condition: { $0.count >= 3 }, failure: {
            ValidatorService.highlightErrorOn(nameTextField)
        }) {
            ValidatorService.clearErrorsOn(nameTextField)
            result = true
        }
        
        return result
    }
    
    static func isSwitchOn(_ itemSwitch: UISwitch?) -> Bool {
        if let itemSwitch = itemSwitch, itemSwitch.isOn {
            return true
        }
        
        return false
    }
}
