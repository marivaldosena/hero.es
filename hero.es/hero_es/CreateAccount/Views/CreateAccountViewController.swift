//
//  CreateAccountViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 23/10/20.
//

import UIKit

// MARK: - CreateAccountViewController: UIViewController
class CreateAccountViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var acceptTermsOfServiceSwitch: UISwitch!
    @IBOutlet weak var acceptTermsOfServiceAgreementLabel: UILabel!
    @IBOutlet weak var openTermsOfServiceButton: UIButton!
    
    var viewModel = CreateAccountViewModel()
    
    // MARK: - Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        if ValidatorService.isNameValid(nameTextField) && ValidatorService.isEmailValid(emailTextField) && ValidatorService.isPasswordValid(passwordTextField) && self.hasUserAcceptedTermsOfService() {
            let username: String = ValidatorService.getNormalizedData(nameTextField)
            let email: String = ValidatorService.getNormalizedData(emailTextField)
            let password: String = ValidatorService.getNormalizedData(passwordTextField)
            
            let createCredentials = CreateAuthCredentialsModel(username: username, email: email, password: password)
            EmailAuthService.shared.createAccount(createCredentials: createCredentials) { authCredentials, error in
                if let error = error {
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Create Account",
                                                  message: "Something went wrong! Try again.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                if authCredentials != nil {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func openTermsOfService(_ sender: UIButton) {
        
    }
    
    @IBAction func goToHome(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            _ = ValidatorService.isNameValid(nameTextField)
        case emailTextField:
            _ = ValidatorService.isEmailValid(emailTextField)
        case passwordTextField:
            _ = ValidatorService.isPasswordValid(passwordTextField)
        default:
            break
        }
    }
    
    // MARK: - Private Methods
    private func hasUserAcceptedTermsOfService() -> Bool {
        if ValidatorService.isSwitchOn(acceptTermsOfServiceSwitch) {
            return true
        }
        
        self.askUserForAcceptingTermsOfService()
        return false
    }
    
    private func askUserForAcceptingTermsOfService() {
        AlertUtils.displayMessage(self, title: "Create Account", message: "You should accept the Terms of Service.", okButton: "OK")
    }
}