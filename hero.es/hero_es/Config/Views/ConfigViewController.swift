//
//  ConfigViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 02/11/20.
//

import UIKit
import Firebase

protocol ConfigViewControllerDelegate {
    func didDarkModeChange()
}

class ConfigViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var changeDataButton: UIButton!
    @IBOutlet weak var deleteUserButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    var delegate: ConfigViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Config"
        
        setupUI()
        setupDarkModeSwitch()
    }
    
    @IBAction func changeUserData(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteUser(_ sender: UIButton) {
        
    }
    
    @IBAction func logoutUser(_ sender: UIButton) {
        EmailAuthService.shared.logout { isFinished, error in
            if isFinished {
                if let error = error {
                    print(error.localizedDescription)
                }                
            }
        }
        
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func darkModeChanged(_ sender: Any) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.setValue(darkModeSwitch.isOn, forKey: "darkModeKey")
        delegate?.didDarkModeChange()
    }
    
    private func setupDarkModeSwitch() {
        let defaults: UserDefaults = UserDefaults.standard
        let isDarkMode: Bool = defaults.bool(forKey: "darkModeKey")
        darkModeSwitch.setOn(isDarkMode, animated: true)
    }
}

//MARK: - ConfigViewController: Private Methods - Setup UI
extension ConfigViewController {
    private func setupUI() {
        setupView()
        setupButtonsWithValues()
        setupTextFields()
    }
    
    private func setupView() {
        SetupViewsManager.setupView(with: view)
    }
    
    private func setupButtonsWithValues() {
        SetupViewsManager.setupButtons(with: changeDataButton, backgroundColor: StyleGuide.Button.loginButton, titleColor: StyleGuide.Color.white)
        SetupViewsManager.setupButtons(with: deleteUserButton, backgroundColor: StyleGuide.Button.createAccountButton, titleColor: StyleGuide.Color.darkGray)
        SetupViewsManager.setupButtons(with: logoutButton, backgroundColor: StyleGuide.Color.gray, titleColor: StyleGuide.Color.white)
    }
    
    private func setupTextFields() {
        SetupViewsManager.setupTextFields(with: emailTextField, placeHolder: "E-mail")
        SetupViewsManager.setupTextFields(with: oldPasswordTextField, placeHolder: "Old password")
        SetupViewsManager.setupTextFields(with: newPasswordTextField, placeHolder: "New password")
        SetupViewsManager.setupTextFields(with: confirmNewPasswordTextField, placeHolder: "Confirm new password")
    }
}
