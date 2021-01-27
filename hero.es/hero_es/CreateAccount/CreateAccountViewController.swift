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
    @IBOutlet weak var termsServiceButton: UIButton!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var createAccountDescriptionLabel: UILabel!
    @IBOutlet weak var haveAccountButton: UIButton!
    @IBOutlet weak var termsDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
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
    
    @IBAction func haveAccountBackSignIn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

//MARK: - CreateAccountViewController: Private Methods - Setup UI
extension CreateAccountViewController {
    private func setupUI() {
        setupView()
        setupButtons()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupLabels()
    }
    
    private func setupView() {
        view.backgroundColor = StyleGuide.Color.lightGray
    }
    
    private func setupButtons() {
        createAccountButton.backgroundColor = StyleGuide.Button.loginButton
        createAccountButton.setTitleColor(StyleGuide.Color.white, for: .normal)
        createAccountButton.roundCorners(cornerRadius: 10, corners: .allCorners)
        
        termsServiceButton.backgroundColor = StyleGuide.Button.createAccountButton
        termsServiceButton.setTitleColor(StyleGuide.Color.darkGray, for: .normal)
        termsServiceButton.roundCorners(cornerRadius: 10, corners: .allCorners)
        
        haveAccountButton.backgroundColor = StyleGuide.Color.clear
        haveAccountButton.setTitleColor(StyleGuide.Color.blue, for: .normal)
    }
    
    private func setupNameTextField() {
        nameTextField.backgroundColor = StyleGuide.Color.clear
        nameTextField.textColor = StyleGuide.Color.gray
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = StyleGuide.Color.gray.cgColor
        nameTextField.roundCorners(cornerRadius: 10, corners: .allCorners)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.Color.gray])
    }
    
    private func setupEmailTextField() {
        emailTextField.backgroundColor = StyleGuide.Color.clear
        emailTextField.textColor = StyleGuide.Color.gray
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = StyleGuide.Color.gray.cgColor
        emailTextField.roundCorners(cornerRadius: 10, corners: .allCorners)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.Color.gray])
    }
    
    private func setupPasswordTextField() {
        passwordTextField.backgroundColor = StyleGuide.Color.clear
        passwordTextField.textColor = StyleGuide.Color.gray
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = StyleGuide.Color.gray.cgColor
        passwordTextField.roundCorners(cornerRadius: 10, corners: .allCorners)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.Color.gray])
    }
    
    private func setupLabels() {
        appNameLabel.textColor = StyleGuide.Color.gray
        createAccountDescriptionLabel.textColor = StyleGuide.Color.gray
        termsDescriptionLabel.textColor = StyleGuide.Color.gray
    }
}

// MARK: - CreateAccountViewController: UITextFieldDelegate
extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            UITextFieldUtils.setFocus(on: emailTextField, from: nameTextField)
        case emailTextField:
            UITextFieldUtils.setFocus(on: passwordTextField, from: emailTextField)
        case passwordTextField:
            UITextFieldUtils.setFocus(on: nil, from: passwordTextField)
        default:
            UITextFieldUtils.setFocus(on: nil, from: nil)
        }
        
        return true
    }
}
