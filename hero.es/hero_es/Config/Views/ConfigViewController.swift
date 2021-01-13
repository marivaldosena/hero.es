//
//  ConfigViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 02/11/20.
//

import UIKit
import Firebase

class ConfigViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var changeDataButton: UIButton!
    @IBOutlet weak var deleteUserButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeUserData(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteUser(_ sender: UIButton) {
        
    }
    
    @IBAction func logoutUser(_ sender: UIButton) {
        AuthService.shared.logout { isFinished, error in
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
}
