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
    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem?
    
    private var viewModel: HeroDetailsViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cornersToRound: UIRectCorner = [.bottomRight, .bottomLeft]
        heroImageView?.roundCorners(cornerRadius: 30, corners: cornersToRound)
        
        self.updateUIInterface()
        self.setAllIdentifiers()
    }
    
    static func getViewController(_ item: HeroModel?) -> HeroDetailsViewController? {
        guard let viewController = UIStoryboard(name: "HeroDetails", bundle: nil).instantiateInitialViewController() as? HeroDetailsViewController else {
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
