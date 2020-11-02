//
//  ViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 20/10/20.
//

import UIKit

class MainViewController: UIViewController {
    @IBAction func openTesteController() {
        var arrayTabVC: [UIViewController] = []
        var uiNavigationController: UINavigationController
        
        if let heroesListVC = UIStoryboard(name: "HeroesList", bundle: nil).instantiateInitialViewController() as? HeroesListViewController {
            uiNavigationController = UINavigationController(rootViewController: heroesListVC)
            heroesListVC.tabBarItem = UITabBarItem(title: "Heroes", image: UIImage(systemName: "person.3"), tag: 0)
            
            arrayTabVC.append(uiNavigationController)
        }
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = arrayTabVC
            
        
        navigationController?.pushViewController(tabBarController, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

