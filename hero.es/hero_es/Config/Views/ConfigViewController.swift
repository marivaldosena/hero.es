//
//  ConfigViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 02/11/20.
//

import UIKit
import Localize_Swift

class ConfigViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var changeDataButton: UIButton!
    @IBOutlet weak var deleteUserButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var changeLanguageButton: UIButton!
    @IBOutlet weak var editUserDataLabel: UILabel!
    
    var viewModel = ConfigViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUILanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self)
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
    
    @IBAction func changeLanguage(_ sender: UIButton) {
        updateUILanguage()
    }
}
