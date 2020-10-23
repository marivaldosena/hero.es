//
//  ViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 20/10/20.
//

import UIKit

class MainViewController: UIViewController {
    @IBAction func openTesteController() {
        if let viewController = HeroesListViewController    .getViewController() {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

