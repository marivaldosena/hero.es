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
            navigationController?.pushViewController(viewController, animated: true)
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
        
        if let heroesListVC = self.createTabBarItem(storyBoardName: "HeroesList", tabName: "Heroes", iconName: "person.3", tagNumber: TabBarItemTag.heroes, withNavigation: true) {
            arrayTabVC.append(heroesListVC)
        }
        
        if let comicsListVC = self.createTabBarItem(storyBoardName: "ComicsList", tabName: "Comics", iconName: "book", tagNumber: TabBarItemTag.comics, withNavigation: true) {
            arrayTabVC.append(comicsListVC)
        }
        
        if let favoritesVC = self.createTabBarItem(storyBoardName: "Favorites", tabName: "Favorites", iconName: "book", tagNumber: TabBarItemTag.favorites, withNavigation: true) {
            arrayTabVC.append(favoritesVC)
        }
        
        if let favoritesVC = self.createTabBarItem(storyBoardName: "Config", tabName: "Config", iconName: "gear", tagNumber: TabBarItemTag.config, withNavigation: true) {
            arrayTabVC.append(favoritesVC)
        }
        
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = arrayTabVC
            
        
        navigationController?.pushViewController(tabBarController, animated: true)
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
        
        
}
