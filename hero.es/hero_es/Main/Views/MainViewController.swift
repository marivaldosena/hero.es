//
//  ViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 20/10/20.
//

import UIKit

//MARK: - MainViewController: UIViewController
class MainViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var loginWithEmailButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginSocialDescriptionLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var welcomeDescriptionLabel: UILabel!
    
    var viewModel: MainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        //TODO: glayce (reverter apos os testes)
//        doLoginIfCredentialsAreCorrect()
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
            //TODO: glayce (pesquisar como abrir a tela e mostrar a navigation com o botao de voltar)
//            navigationController?.pushViewController(viewController, animated: true)
            navigationController?.present(viewController, animated: true, completion: nil)
        }
    }
}

//MARK: - MainViewController: Private Methods - Setup UI
extension MainViewController {
    private func setupUI() {
        setupView()
        setupButtons()
        setupTextFields()
        setupLabels()
    }
    
    private func setupView() {
        SetupViewsManager.setupView(with: view)
    }
    
    private func setupButtons() {
        SetupViewsManager.setupButtons(with: loginWithEmailButton, backgroundColor: StyleGuide.Button.loginButton, titleColor: StyleGuide.Color.white)
        
        SetupViewsManager.setupButtons(with: createAccountButton, backgroundColor: StyleGuide.Button.createAccountButton, titleColor: StyleGuide.Color.darkGray)
    }
    
    private func setupTextFields() {
        SetupViewsManager.setupTextFields(with: emailTextField, placeHolder: "E-mail")
        SetupViewsManager.setupTextFields(with: passwordTextField, placeHolder: "Password")
    }
    
    private func setupLabels() {
        SetupViewsManager.setupLabels(with: loginSocialDescriptionLabel)
        SetupViewsManager.setupLabels(with: appNameLabel)
        SetupViewsManager.setupLabels(with: welcomeDescriptionLabel)
    }
}

extension MainViewController: ConfigViewControllerDelegate {
    func didDarkModeChange() {
        setupUI()
    }
}
