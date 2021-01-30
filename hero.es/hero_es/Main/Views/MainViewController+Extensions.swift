//
//  MainViewController+Extensions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 04/01/21.
//

import Foundation
import UIKit

// MARK: - MainViewController Public Methods
extension MainViewController {
    func login(with service: LoginServiceType) {
        switch service {
        case .email:
            //TODO: glayce: voltar após os testes
//            self.loginWithEmail()
            self.createTabBarNavigation()
        case .facebook:
            self.loginWithFacebookAccount()
        case .google:
            self.loginWithGoogleAccount()
        default:
            break
        }
    }
    
    func doLoginIfCredentialsAreCorrect() {
        if EmailAuthService.shared.getCurrentUser() != nil {
            DispatchQueue.main.async {
                self.clearFields()
                self.createTabBarNavigation()
            }
        }
    }
}

// MARK: - MainViewController Private Methods
extension MainViewController {
    private func loginWithEmail() {
        if viewModel.isCorrectLoginWith(email: emailTextField, password: passwordTextField) {
            let email = ValidatorService.getNormalizedData(emailTextField)
            let password = ValidatorService.getNormalizedData(passwordTextField)
            
            MainService.shared.loginWithEmailAndPassword(email, password) { (authCredentials, error) in
                if let error = error {
                    print(error.localizedDescription)
                    AlertUtils.displayMessage(
                        self,
                        title: self.viewModel.getString(for: .loginButtonTitle),
                        message: self.viewModel.getString(for: .failedLoginMessage),
                        okButton: self.viewModel.getString(for: .positiveButton)
                    )
                }
                
                self.doLoginIfCredentialsAreCorrect()
            }
        }
    }
    
    private func loginWithGoogleAccount() {
        GoogleAuthService().loginWithGoogle(self, { (authCredentials, error) in
            if let error = error {
                AlertUtils.displayMessage(
                    self,
                    title: "Google Login Error",
                    message: "\(error.localizedDescription)",
                    okButton: "Ok"
                )
            }
            
            if let _ = authCredentials {
                self.doLoginIfCredentialsAreCorrect()
            }
        })
    }
    
    private func loginWithFacebookAccount() {
        FacebookAuthService().loginWithFacebook(self) { (authCredentials, error) in
            if let error = error {
                AlertUtils.displayMessage(
                    self,
                    title: "Facebook Login Error",
                    message: "\(error.localizedDescription)",
                    okButton: "Ok"
                )
            }
            
            if let _ = authCredentials {
                self.doLoginIfCredentialsAreCorrect()
            }
        }
    }
    
    private func createTabBarNavigation() {
        guard let heroesController = viewModel.getController(for: .heroes, withNagigation: true) else { return }
        guard let comicsController = viewModel.getController(for: .comics, withNagigation: true) else { return }
        guard let favoritesController = viewModel.getController(for: .favorites, withNagigation: true) else { return }
        // TODO: Fix ConfigViewController to work with both and navigation and not
        guard let configController = viewModel.getController(for: .config, withNagigation: true) else { return }
        
        let arrayTabVC: [UIViewController] = [
            heroesController,
            comicsController,
            favoritesController,
            configController
        ]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = arrayTabVC
        //TODO: glayce (pesquisar como abrir a tela e mostrar a navigation com o botao de voltar)
        navigationController?.pushViewController(tabBarController, animated: true)
        
        //        navigationController?.present(tabBarController, animated: true, completion: nil)
    }
    
    private func clearFields() {
        emailTextField.text = nil
        passwordTextField.text = nil
    }
}

// MARK: - MainViewController: UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        switch textField {
        case emailTextField:
            UITextFieldUtils.setFocus(on: passwordTextField, from: emailTextField)
        case passwordTextField:
            UITextFieldUtils.setFocus(on: nil, from: passwordTextField)
            passwordTextField.resignFirstResponder()
            loginWithEmailButton.becomeFirstResponder()
            login(with: .email)
        default:
            UITextFieldUtils.setFocus(on: nil, from: nil)
        }
        return true
    }
}
