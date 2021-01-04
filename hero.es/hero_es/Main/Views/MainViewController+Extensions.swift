//
//  MainViewController+Extensions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 04/01/21.
//

import Foundation
import UIKit

// MARK: - MainViewController
extension MainViewController {
    // MARK: - MainViewController: Public Methods
    func login(with service: LoginServiceType) {
        switch service {
        case .email:
            self.loginWithEmail()
        case .facebook:
            self.loginWithFacebookAccount()
        case .google:
            self.loginWithGoogleAccount()
        default:
            break
        }
    }
    
    func doLoginIfCredentialsAreCorrect() {
        if AuthService.shared.getCurrentUser() != nil {
            DispatchQueue.main.async {
                self.createTabBarNavigation()
            }
        }
    }
    
    // MARK: - MainViewController: Private Methods
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
        
    }
    
    private func loginWithFacebookAccount() {
        
    }
    
    private func createAccount() {
        
    }
    
    private func createTabBarNavigation() {
        guard let heroesController = viewModel.getController(for: .heroes) else { return }
        guard let comicsController = viewModel.getController(for: .comics) else { return }
        guard let favoritesController = viewModel.getController(for: .favorites) else { return }
        guard let configController = viewModel.getController(for: .config) else { return }
        
        let arrayTabVC: [UIViewController] = [
            heroesController,
            comicsController,
            favoritesController,
            configController
        ]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = arrayTabVC
            
        navigationController?.pushViewController(tabBarController, animated: true)
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
        default:
            UITextFieldUtils.setFocus(on: nil, from: nil)
        }
        return true
    }
}
