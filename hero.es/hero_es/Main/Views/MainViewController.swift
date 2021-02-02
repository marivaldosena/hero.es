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
    @IBOutlet weak var loginSocialDescriptionLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var welcomeDescriptionLabel: UILabel!
    @IBOutlet weak var socialLoginContainer: UIStackView!
    
    var viewModel: MainViewModel = MainViewModel()
    private var appTabBarController = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let localization = viewModel.getLocalizationService()
        localization.addObserver(self)
        updateUIInterface()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
            let localization = viewModel.getLocalizationService()
            localization.addObserver(viewController)
            localization.loadTranslations()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func getTabBarController() -> UITabBarController {
        return appTabBarController
    }
}

//MARK: - MainViewController: Private Methods - Setup UI
extension MainViewController {
    private func setupUI() {
        setupView()
        setupButtons()
        setupTextFields()
        setupLabels()
        setupSocialLoginButtons()
    }
    
    private func setupView() {
        SetupViewsManager.setupView(with: view)
    }
    
    private func setupButtons() {
        SetupViewsManager.setupButtons(with: loginWithEmailButton, backgroundColor: StyleGuide.Button.loginButton, titleColor: StyleGuide.Color.white)
        
        SetupViewsManager.setupButtons(with: createAccountButton, backgroundColor: StyleGuide.Button.createAccountButton, titleColor: StyleGuide.Color.darkGray)
    }
    
    private func setupTextFields() {
        SetupViewsManager.setupTextFields(with: emailTextField, placeHolder: viewModel.getEmailString())
        SetupViewsManager.setupTextFields(with: passwordTextField, placeHolder: viewModel.getPasswordString())
    }
    
    private func setupLabels() {
        SetupViewsManager.setupLabels(with: loginSocialDescriptionLabel)
        SetupViewsManager.setupLabels(with: appNameLabel)
        SetupViewsManager.setupLabels(with: welcomeDescriptionLabel)
    }
    
    private func setupSocialLoginButtons() {
        SetupViewsManager.setupView(with: socialLoginContainer, backgroundColor: StyleGuide.Color.lightGray)
        
        for item in socialLoginContainer.subviews {
            SetupViewsManager.setupView(with: item, backgroundColor: StyleGuide.Color.lightGray)
        }
    }
}

extension MainViewController: ConfigViewControllerDelegate {
    func didDarkModeChange() {
        setupUI()
    }
}
