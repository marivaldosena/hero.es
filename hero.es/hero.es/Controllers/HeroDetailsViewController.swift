//
//  TesteViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 21/10/20.
//

import UIKit

//MARK: - HeroDetailsViewController: UIViewController
class HeroDetailsViewController: UIViewController {
    @IBOutlet weak var heroImageView: UIImageView?
    @IBOutlet weak var heroNameLabel: UILabel?
    @IBOutlet weak var heroPublisherNameLabel: UILabel?
    @IBOutlet weak var heroDescriptionTextView: UITextView?
    @IBOutlet weak var shareButton: UIButton?
    @IBOutlet weak var favoriteButton: UIBarButtonItem?
    
    
    private var item: Hero? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUIInterface()
    }
    
    static func getViewController(_ item: Hero?) -> HeroDetailsViewController? {
        guard let uiNavigationController = UIStoryboard(name: "HeroDetails", bundle: nil).instantiateInitialViewController() as? UINavigationController else {
            return nil
        }
        
        guard let viewController = uiNavigationController.topViewController as? HeroDetailsViewController else {
            return nil
        }
        
        viewController.item = item
        return viewController
    }
}

//MARK: - HeroDetailsViewController
extension HeroDetailsViewController {
    func updateUIInterface() {
        guard let hero = self.item else {
            self.resetUIInterface()
            return
        }
        
        DispatchQueue.main.async {
            self.heroImageView?.image = UIImage(named: hero.imageName)
            self.heroNameLabel?.text = hero.name
            self.heroPublisherNameLabel?.text = "Marvel"
            self.heroDescriptionTextView?.text = hero.description
        }
    }
    
    func resetUIInterface() {
        DispatchQueue.main.async {
            self.heroImageView?.image = UIImage(named: "HeroImage")
            self.heroNameLabel?.text = "Hero Name"
            self.heroPublisherNameLabel?.text = "Marvel"
            self.heroDescriptionTextView?.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        }
    }
}
