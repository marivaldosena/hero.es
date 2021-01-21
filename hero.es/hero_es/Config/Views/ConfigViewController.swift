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
