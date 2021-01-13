//
//  TesteViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 21/10/20.
//

import UIKit
import Kingfisher

//MARK: - HeroDetailsViewController: UIViewController
class HeroDetailsViewController: UIViewController {
    @IBOutlet weak var heroImageView: UIImageView?
    @IBOutlet weak var heroNameLabel: UILabel?
    @IBOutlet weak var heroPublisherNameLabel: UILabel?
    @IBOutlet weak var heroDescriptionTextView: UITextView?
    @IBOutlet weak var shareButton: UIButton?
    @IBOutlet weak var favoriteButton: UIBarButtonItem?
    
    private var viewModel: HeroDetailsViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUIInterface()
        self.setAllIdentifiers()
    }
    
    @IBAction func shareHeroItem(_ sender: UIButton) {
        guard let heroName = viewModel?.getName() else { return }
        guard let heroUrl = viewModel?.getUrl() else { return }
        guard let heroImage = self.getHeroImage(urlString: viewModel?.getImageUrl()) else { return }
        
        let itemsToShare = [heroName, heroUrl, heroImage] as [Any]
        let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        self.present(controller, animated: true, completion: nil)
    }
    
    static func getViewController(_ item: HeroModel?) -> HeroDetailsViewController? {
        guard let uiNavigationController = UIStoryboard(name: "HeroDetails", bundle: nil).instantiateInitialViewController() as? UINavigationController else {
            return nil
        }
        
        guard let viewController = uiNavigationController.topViewController as? HeroDetailsViewController else {
            return nil
        }
        
        viewController.viewModel = HeroDetailsViewModel(with: item)
        return viewController
    }
    
    func getViewModel() -> HeroDetailsViewModel? {
        return self.viewModel
    }
    
    func setViewModel(_ viewModel: HeroDetailsViewModel) {
        self.viewModel = viewModel
        self.updateUIInterface()
    }
}
