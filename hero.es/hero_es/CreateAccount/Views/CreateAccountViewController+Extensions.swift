//
//  CreateAccountViewController+Extensions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation
import UIKit

// MARK: - CreateAccountViewController
extension CreateAccountViewController {
    func updateUIInterface() {
        do {
            DispatchQueue.main.async {
                self.nameTextField?.placeholder = self.viewModel.getNameString()
                self.emailTextField?.placeholder = self.viewModel.getEmailString()
                self.passwordTextField?.placeholder = self.viewModel.getPasswordString()
                //self.createAccountButton.setTitle(self.viewModel.getCreateAccountButtonTitle(), for: .normal)
                self.termsDescriptionLabel?.text = self.viewModel.getTermsOfServiceAgreementString()
                //self.termsServiceButton.setTitle(self.viewModel.getCreateAccountButtonTitle(), for: .normal)
            }
        } catch {
            print("DEBUG: CreateAccountViewController.updateUIInterface - \(error.localizedDescription)")
        }
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

// MARK: - CreateAccountViewController: UpdateLanguageProtocol
extension CreateAccountViewController: UpdateLanguageProtocol {
    func languageDidChange(_ language: AvailableLanguage) {
        updateUIInterface()
    }
}
