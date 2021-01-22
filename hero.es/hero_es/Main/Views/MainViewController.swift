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
        
        let configViewController = ConfigViewController()
        configViewController.delegate = self
        setupUI()
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
        setupEmailTextField()
        setupPasswordTextField()
        setupLabels()
    }
    
    private func setupView() {
        view.backgroundColor = StyleGuide.Color.lightGray
    }
    
    private func setupButtons() {
        loginWithEmailButton.backgroundColor = StyleGuide.Button.loginButton
        loginWithEmailButton.setTitleColor(StyleGuide.Color.white, for: .normal)
        loginWithEmailButton.roundCorners(cornerRadius: 10, corners: .allCorners)
        
        createAccountButton.backgroundColor = StyleGuide.Button.createAccountButton
        createAccountButton.setTitleColor(StyleGuide.Color.darkGray, for: .normal)
        createAccountButton.roundCorners(cornerRadius: 10, corners: .allCorners)
    }
    
    private func setupEmailTextField() {
        emailTextField.backgroundColor = StyleGuide.Color.clear
        emailTextField.textColor = StyleGuide.Color.gray
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = StyleGuide.Color.gray.cgColor
        emailTextField.roundCorners(cornerRadius: 10, corners: .allCorners)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.Color.gray])
    }
    
    private func setupPasswordTextField() {
        passwordTextField.backgroundColor = StyleGuide.Color.clear
        passwordTextField.textColor = StyleGuide.Color.gray
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = StyleGuide.Color.gray.cgColor
        passwordTextField.roundCorners(cornerRadius: 10, corners: .allCorners)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.Color.gray])
    }
    
    private func setupLabels() {
        loginSocialDescriptionLabel.textColor = StyleGuide.Color.gray
        appNameLabel.textColor = StyleGuide.Color.gray
        welcomeDescriptionLabel.textColor = StyleGuide.Color.gray
    }
}

extension MainViewController: ConfigViewControllerDelegate {
    func didDarkModeChange() {
        setupUI()
    }
}
