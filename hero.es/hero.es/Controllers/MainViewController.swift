//
//  ViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 20/10/20.
//

import UIKit

//MARK: - LoginType
enum LoginServiceType {
    case facebook
    case google
    case email
}

enum TabBarItemTag {
    static let heroes = 0
    static let comics = 1
    static let favorites = 2
    static let config = 3
}

//MARK: - MainViewController: UIViewController
class MainViewController: UIViewController {
    @IBOutlet weak var textFieldEmail: UITextField?
    @IBOutlet weak var textFieldPassword: UITextField?
    @IBOutlet weak var buttonFacebook: UIButton?
    @IBOutlet weak var buttonGoogle: UIButton?
    @IBOutlet weak var buttonLoginWithEmail: UIButton?
    @IBOutlet weak var buttonCreateAccount: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: UIButton) {
        switch sender {
        case buttonLoginWithEmail:
            self.login(with: .email)
        case buttonFacebook:
            self.login(with: .facebook)
        case buttonGoogle:
            self.login(with: .google)
        default:
            break
        }
    }
    
    @IBAction func register(_ sender: UIButton) {
        if let viewController = UIStoryboard(name: "CreateAccount", bundle: nil).instantiateInitialViewController() as? CreateAccountViewController {
            let navController = UINavigationController(rootViewController: viewController)
            navigationController?.pushViewController(navController, animated: true)
        }
    }
    
    private func login(with service: LoginServiceType) {
        switch service {
        case .email:
            self.loginWithEmail()
        case .facebook:
            self.loginWithFacebookAccount()
        case .google:
            self.loginWithGoogleAccount()
        default:
            break
        }
    }
    
    private func loginWithEmail() {
        if ValidatorService.isEmailValid(textFieldEmail) && ValidatorService.isPasswordValid(textFieldPassword) {
            let email = ValidatorService.getNormalizedData(textFieldEmail)
            let password = ValidatorService.getNormalizedData(textFieldPassword)
            
            FirebaseService.loginWithEmailAndPassword(email, password) {
                self.doSuccessfullCredentialsLoginBehavior()
            } failure: {
                AlertUtils.displayMessage(self, title: "Login", message: "Login and/or password are wrong.", okButton: "OK")
            }
        }
    }
    
    private func loginWithGoogleAccount() {
        
    }
    
    private func loginWithFacebookAccount() {
        
    }
    
    private func createAccount() {
        
    }
    
    private func doSuccessfullCredentialsLoginBehavior() {
        self.createTabBarNavigation()
    }
    
    private func createTabBarItem(storyBoardName: String, tabName: String, iconName: String, tagNumber: Int) -> UIViewController? {
        if let viewController = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController() {

            viewController.tabBarItem = UITabBarItem(title: tabName, image: UIImage(systemName: iconName), tag: tagNumber)
            
            
            return viewController
        }
        
        return nil
    }
    
    private func createTabBarItem(storyBoardName: String, tabName: String, iconName: String, tagNumber: Int, withNavigation: Bool) -> UINavigationController? {
        guard let viewController = self.createTabBarItem(storyBoardName: storyBoardName, tabName: tabName, iconName: iconName, tagNumber: tagNumber) else {
            return nil
        }
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.title = tabName
        
        return navController
    }
    
    private func createTabBarNavigation() {
        var arrayTabVC: [UIViewController] = []
        
        let items = [
            (storyboardName: "HeroesList", tabName: "Heroes", iconName: "person.3", tagNumber: TabBarItemTag.heroes),
            (storyboardName: "ComicsList", tabName: "Comics", iconName: "book", tagNumber: TabBarItemTag.comics),
            (storyboardName: "Favorites", tabName: "Favorites", iconName: "heart", tagNumber: TabBarItemTag.favorites),
            (storyboardName: "Config", tabName: "Config", iconName: "gear", tagNumber: TabBarItemTag.config)
        ]
        
        for item in items {
            if let viewController = self.createTabBarItem(storyBoardName: item.storyboardName, tabName: item.tabName, iconName: item.iconName, tagNumber: item.tagNumber, withNavigation: true) {
                arrayTabVC.append(viewController)
            }
        }

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = arrayTabVC
            
        navigationController?.pushViewController(tabBarController, animated: true)
    }
}
