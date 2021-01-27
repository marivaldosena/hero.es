//
//  ConfigViewController+Extensions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation
import UIKit
import Localize_Swift

// MARK: - ConfigViewController
extension ConfigViewController {
    func updateUIInterface() {
        DispatchQueue.main.async {
            self.editUserDataLabel.text = self.viewModel.getEditUserDataString()
            self.emailTextField.placeholder = self.viewModel.getEmailString()
            self.oldPasswordTextField.placeholder = self.viewModel.getOldPasswordString()
            self.newPasswordTextField.placeholder = self.viewModel.getNewPasswordString()
            self.confirmNewPasswordTextField.placeholder = self.viewModel.getConfirmPasswordString()
            self.changeDataButton.setTitle(self.viewModel.getChangeDataString(), for: .normal)
            self.changeLanguageButton.setTitle(self.viewModel.getChangeLanguageString(), for: .normal)
            self.deleteUserButton.setTitle(self.viewModel.getDeleteUserString(), for: .normal)
            self.logoutButton.setTitle(self.viewModel.getLogoutString(), for: .normal)
        }
    }
    
    @objc func updateUILanguage() {
        let actionSheet = UIAlertController(title: "Available Languages", message: "Switch Language", preferredStyle: UIAlertController.Style.actionSheet)
        let availableLanguages = LocalizationService().getAvailableLanguages()
        
        for language in availableLanguages {
            let languageAction = UIAlertAction(title: language.languageName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                LocalizationService.shared.setCurrent(language: language)
                self.updateUIInterface()
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
}
