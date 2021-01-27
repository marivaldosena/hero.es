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
    func updateUIInterface() {
        DispatchQueue.main.async {
            self.emailTextField.placeholder = self.viewModel.getEmailString()
            self.passwordTextField.placeholder = self.viewModel.getPasswordString()
            self.loginWithEmailButton.setTitle(self.viewModel.getLoginButtonTitle(), for: .normal)
            self.dontHaveAccountLabel.text = self.viewModel.getDontHaveAccountString()
            self.createAccountButton.setTitle(self.viewModel.getCreateAccountButtonTitle(), for: .normal)
            self.updateTabBarItemsTitle()
        }
    }
    
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
        if EmailAuthService.shared.getCurrentUser() != nil {
            DispatchQueue.main.async {
                self.clearFields()
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
                        title: self.viewModel.getLoginButtonTitle(),
                        message: self.viewModel.getFailedLoginMessage(),
                        okButton: self.viewModel.getPositiveButtonString()
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
        guard let configController = viewModel.getController(for: .config) else { return }
        
        let arrayTabVC: [UIViewController] = [
            heroesController,
            comicsController,
            favoritesController,
            configController
        ]
        
        for controller in arrayTabVC {
            configureLocalization(controller: controller)
        }
        
        let tabBarController = getTabBarController()
        tabBarController.viewControllers = arrayTabVC
            
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    private func clearFields() {
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
    private func updateTabBarItemsTitle() {
        guard let items = getTabBarController().tabBar.items else { return }
        
        items[0].title = viewModel.getTabBarItemTitleName(for: .heroes)
        items[1].title = viewModel.getTabBarItemTitleName(for: .comics)
        items[2].title = viewModel.getTabBarItemTitleName(for: .favorites)
        items[3].title = viewModel.getTabBarItemTitleName(for: .config)
    }
    
    private func configureLocalization(controller: UIViewController) {
        let localization = viewModel.getLocalizationService()
        localization?.addObserver(controller as? UpdateLanguageProtocol)
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

// MARK: - MainViewController: UpdateLanguageProtocol
extension MainViewController: UpdateLanguageProtocol {
    func languageDidChange(_ language: AvailableLanguage) {
        updateUIInterface()
    }
}
