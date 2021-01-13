//
//  HeroDetailsViewController+Extensions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 30/12/20.
//

import Foundation
import UIKit

//MARK: - HeroDetailsViewController
extension HeroDetailsViewController {
    func updateUIInterface() {
        guard let viewModel = self.getViewModel() else { return }
        title = viewModel.getName()
        
        DispatchQueue.main.async {
            self.displayHeroImage(urlString: viewModel.getImageUrl())
            self.heroNameLabel?.text = viewModel.getName()
            self.heroPublisherNameLabel?.text = viewModel.getPublisherName()
            self.heroDescriptionTextView?.text = viewModel.getDescription()
        }
    }
    
    func displayHeroImage(urlString: String?) {
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
    
    func getHeroImage(urlString: String?) -> UIImage? {
        self.displayHeroImage(urlString: urlString)
        return self.heroImageView?.image
    }
    
    
    func setAllIdentifiers() {
        guard let viewModel = self.getViewModel() else { return }
        
        heroImageView?.accessibilityIdentifier = viewModel.getIdentifier(for: .heroImage)
        heroNameLabel?.accessibilityIdentifier = viewModel.getIdentifier(for: .heroName)
        heroPublisherNameLabel?.accessibilityIdentifier = viewModel.getIdentifier(for: .heroPublisher)
        heroDescriptionTextView?.accessibilityIdentifier = viewModel.getIdentifier(for: .heroDescription)
        shareButton?.accessibilityIdentifier  = viewModel.getIdentifier(for: .shareButton)
        favoriteButton?.accessibilityIdentifier  = viewModel.getIdentifier(for: .favoriteButton)
    }
}
