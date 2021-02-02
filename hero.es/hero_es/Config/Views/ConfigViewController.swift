//
//  ConfigViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 02/11/20.
//

import UIKit
import Localize_Swift

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
    @IBOutlet weak var changeLanguageButton: UIButton!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var appNameDescriptionLabel: UILabel!
    @IBOutlet weak var usersDataDescriptionLabel: UILabel!
    @IBOutlet weak var changeAppThemeLabel: UILabel!
    @IBOutlet weak var darkModeDescriptionLabel: UILabel!
    
    var viewModel = ConfigViewModel()
    
    static var darkModeTeste: Bool?
    
    var didDarkModeChanged: Bool = false {
        didSet {
            ConfigViewController.darkModeTeste = didDarkModeChanged
            setupUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Config"
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUILanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = StyleGuide.Color.darkGray
        appearance.titleTextAttributes = [.foregroundColor: StyleGuide.Label.labelsDescription]
        appearance.largeTitleTextAttributes = [.foregroundColor: StyleGuide.Label.labelsDescription]
        
        navigationController?.navigationBar.standardAppearance = appearance
        
        let defaults: UserDefaults = UserDefaults.standard
        let isDarkMode: Bool = defaults.bool(forKey: "darkModeKey")
        ConfigViewController.darkModeTeste = isDarkMode
        
        setupUI()
        setupDarkModeSwitch()
        
        updateUIInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Config"
        
        updateUIInterface()
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
    
    @IBAction func darkModeChanged(_ sender: Any) {
        didDarkModeChanged = darkModeSwitch.isOn
        let defaults: UserDefaults = UserDefaults.standard
        defaults.setValue(darkModeSwitch.isOn, forKey: "darkModeKey")
    }
    
    private func setupDarkModeSwitch() {
        let defaults: UserDefaults = UserDefaults.standard
        let isDarkMode: Bool = defaults.bool(forKey: "darkModeKey")
        darkModeSwitch.setOn(isDarkMode, animated: true)
    }
    
    @IBAction func changeLanguage(_ sender: UIButton) {
        updateUILanguage()
    }
}

//MARK: - ConfigViewController: Private Methods - Setup UI
extension ConfigViewController {
    private func setupUI() {
        setupView()
        setupButtonsWithValues()
        setupTextFields()
        setupLabels()
    }
    
    private func setupView() {
        SetupViewsManager.setupView(with: view)
    }
    
    private func setupButtonsWithValues() {
        SetupViewsManager.setupButtons(with: changeDataButton, backgroundColor: StyleGuide.Button.changeDataButton, titleColor: StyleGuide.Button.ButtonTextColor.changeDataTextButton)
        SetupViewsManager.setupButtons(with: deleteUserButton, backgroundColor: StyleGuide.Button.deleteUserButton, titleColor: StyleGuide.Button.ButtonTextColor.deleteUserTextButton)
        SetupViewsManager.setupButtons(with: logoutButton, backgroundColor: StyleGuide.Button.changeLanguageButton, titleColor: StyleGuide.Button.ButtonTextColor.changeLanguageTextButton)
        SetupViewsManager.setupButtons(with: changeLanguageButton, backgroundColor: StyleGuide.Button.changeLanguageButton, titleColor: StyleGuide.Button.ButtonTextColor.changeLanguageTextButton)
    }
    
    private func setupTextFields() {
        SetupViewsManager.setupTextFields(with: emailTextField, placeHolder: "E-mail")
        SetupViewsManager.setupTextFields(with: oldPasswordTextField, placeHolder: "Old password")
        SetupViewsManager.setupTextFields(with: newPasswordTextField, placeHolder: "New password")
        SetupViewsManager.setupTextFields(with: confirmNewPasswordTextField, placeHolder: "Confirm new password")
    }
    
    private func setupLabels() {
        SetupViewsManager.setupLabels(with: appNameDescriptionLabel)
        SetupViewsManager.setupLabels(with: usersDataDescriptionLabel)
        SetupViewsManager.setupLabels(with: changeAppThemeLabel)
        SetupViewsManager.setupLabels(with: darkModeDescriptionLabel)
    }
}
