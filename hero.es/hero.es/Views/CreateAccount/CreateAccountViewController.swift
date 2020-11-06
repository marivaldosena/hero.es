//
//  CreateAccountViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 23/10/20.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var acceptTermsOfServiceSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
    }
    
    @IBAction func openTermsOfService(_ sender: UIButton) {
    }
    
}
