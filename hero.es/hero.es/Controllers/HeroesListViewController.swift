//
//  HeroesListViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 21/10/20.
//

import UIKit

class HeroesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func getViewController() -> HeroDetailsViewController? {
        guard let viewController = UIStoryboard(name: "HeroesList", bundle: nil).instantiateInitialViewController() as? HeroDetailsViewController else {
            return nil
        }
        
        return viewController
    }
}
