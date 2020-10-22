//
//  TesteViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 21/10/20.
//

import UIKit

class HeroDetailsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func getViewController() -> HeroDetailsViewController? {
        guard let viewController = UIStoryboard(name: "HeroDetails", bundle: nil).instantiateInitialViewController() as? HeroDetailsViewController else {
            return nil
        }
        
        return viewController
    }

}
