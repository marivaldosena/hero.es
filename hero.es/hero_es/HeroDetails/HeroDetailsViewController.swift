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
    }
    
    @IBAction func shareHeroItem(_ sender: UIButton) {
        guard let heroName = viewModel?.getName() else { return }
        guard let heroUrl = viewModel?.getUrl() else { return }
        guard let heroImage = getHeroImage(urlString: viewModel?.getImageUrl()) else { return }
        
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
    
    private func displayHeroImage(urlString: String?) {
        if let urlString = urlString {
            if urlString != "HeroImage" {
                guard let url = URL(string: urlString) else { return }
                self.heroImageView?.kf.indicatorType = .activity
                self.heroImageView?.kf.setImage(with: url)
            } else {
                self.heroImageView?.image = UIImage(named: urlString)
            }
        }
    }
    
    private func getHeroImage(urlString: String?) -> UIImage? {
        self.displayHeroImage(urlString: urlString)
        return self.heroImageView?.image
    }
}

//MARK: - HeroDetailsViewController
extension HeroDetailsViewController {
    func updateUIInterface() {
        title = viewModel?.getName()
        
        DispatchQueue.main.async {
            self.displayHeroImage(urlString: self.viewModel?.getImageUrl())
            self.heroNameLabel?.text = self.viewModel?.getName()
            self.heroPublisherNameLabel?.text = self.viewModel?.getPublisherName()
            self.heroDescriptionTextView?.text = self.viewModel?.getDescription()
        }
    }
}
