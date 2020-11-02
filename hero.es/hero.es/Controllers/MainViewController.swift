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
        
    }
    
    private func createTabBarItem(storyBoardName: String, tabName: String, iconName: String, tagNumber: Int) -> UIViewController? {
        if let viewController = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController() {

            viewController.tabBarItem = UITabBarItem(title: tabName, image: UIImage(systemName: iconName), tag: tagNumber)
            
            
            return viewController
        }
        
        return nil
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
        self.doSuccessfullCredentialsLoginBehavior()
    }
    
    private func loginWithGoogleAccount() {
        
    }
    
    private func loginWithFacebookAccount() {
        
    }
    
    private func createAccount() {
        
    }
    
    private func doSuccessfullCredentialsLoginBehavior() {
        var arrayTabVC: [UIViewController] = []
        
        if let heroesListVC = self.createTabBarItem(storyBoardName: "HeroesList", tabName: "Heroes", iconName: "person.3", tagNumber: 0) {
            let navController = UINavigationController(rootViewController: heroesListVC)
            heroesListVC.title = "Heroes"
            arrayTabVC.append(navController)
        }
        
        if let comicsListVC = self.createTabBarItem(storyBoardName: "ComicsList", tabName: "Comics", iconName: "book", tagNumber: 1) {
            let navController = UINavigationController(rootViewController: comicsListVC)
            comicsListVC.title = "Comics"
            arrayTabVC.append(navController)
        }
        
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = arrayTabVC
            
        
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    
}
