//
//  CreateAccountViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 23/10/20.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var acceptTermsOfServiceSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        let name: String = self.getNormalizedData(nameTextField)
        let email: String = self.getNormalizedData(emailTextField)
        let password: String = self.getNormalizedData(passwordTextField)

        if self.isNameValid(name) && self.isEmailValid(email) && self.isPasswordValid(password) && self.hasUserAcceptedTermsOfService() {
                FirebaseService.createAccount(username: name, email: email, password: password) {
                    //TODO: Display a message confirming successful registration
                    self.navigationController?.popToRootViewController(animated: true)
                } failure: {
                    let alert = UIAlertController(title: "Create Account", message: "Something went wrong! Try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func openTermsOfService(_ sender: UIButton) {
        
    }
    
    @IBAction func goToHome(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let name: String = self.getNormalizedData(nameTextField)
        let email: String = self.getNormalizedData(emailTextField)
        let password: String = self.getNormalizedData(passwordTextField)
        
        switch textField {
        case nameTextField:
            _ = self.isNameValid(name)
        case emailTextField:
            _ = self.isEmailValid(email)
        case passwordTextField:
            _ = self.isPasswordValid(password)
        default:
            break
        }
    }
    
    private func isValid(_ value: String, condition: (_ field: String) -> Bool, failure: () -> Void) -> Bool {
        if condition(value) {
            return true
        } else {
            failure()
            return false
        }
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        var result = false
        
        if self.isValid(email, condition: { $0.isEmailValid }, failure: {
            self.highlightErrorOn(emailTextField)
        }) {
            self.clearErrorsOn(emailTextField)
            result = true
        }
        
        return result
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        var result = false
        
        if self.isValid(password, condition: { $0.count >= 6 }, failure: {
            self.highlightErrorOn(passwordTextField)
        }) {
            self.clearErrorsOn(passwordTextField)
            result = true
        }
        
        return result
    }
    
    private func isNameValid(_ name: String) -> Bool {
        var result = false
        
        if self.isValid(name, condition: { $0.count >= 3 }, failure: {
            self.highlightErrorOn(nameTextField)
        }) {
            self.clearErrorsOn(nameTextField)
            result = true
        }
        
        return result
    }
    
    private func hasUserAcceptedTermsOfService() -> Bool {
        if acceptTermsOfServiceSwitch.isOn {
            return true
        }
        
        self.askUserForAcceptingTermsOfService()
        return false
    }
    
    private func askUserForAcceptingTermsOfService() {
        AlertUtils.displayMessage(self, title: "Create Account", message: "You should accept the Terms of Service.", okButton: "OK")
    }
    
    private func highlightErrorOn(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
    }
    
    private func clearErrorsOn(_ textField: UITextField) {
        textField.layer.borderColor = .none
        textField.layer.borderWidth = 0.0
    }
    
    private func getNormalizedData(_ textField: UITextField) -> String {
        if let textValue = textField.text {
            return textValue.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return ""
    }
}
