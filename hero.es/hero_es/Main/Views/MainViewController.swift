//
//  ViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 20/10/20.
//

import UIKit
import Localize_Swift

//MARK: - MainViewController: UIViewController
class MainViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var loginWithEmailButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var viewModel: MainViewModel = MainViewModel()
    /*
     Internationalização está funcionando!!!! Saí para lanchar, retorno em breve.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        doLoginIfCredentialsAreCorrect()
    }
    
    @IBAction func login(_ sender: UIButton) {
        switch sender {
        case loginWithEmailButton:
            self.login(with: .email)
        case facebookButton:
            self.login(with: .facebook)
        case googleButton:
            self.login(with: .google)
        default:
            break
        }
    }
    
    @IBAction func register(_ sender: UIButton) {
        if let viewController = UIStoryboard(name: "CreateAccount", bundle: nil).instantiateInitialViewController() as? CreateAccountViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

