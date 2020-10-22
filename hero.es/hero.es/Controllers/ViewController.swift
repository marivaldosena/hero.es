//
//  ViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 20/10/20.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func openTesteController() {
        if let viewController = HeroDetailsViewController.getViewController() {
            present(viewController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
}

