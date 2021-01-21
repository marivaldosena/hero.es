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
            self.heroImageView?.image = viewModel.getImage()
            self.heroNameLabel?.text = viewModel.getName()
            self.heroPublisherNameLabel?.text = viewModel.getPublisherName()
            self.heroDescriptionTextView?.text = viewModel.getDescription()
        }
    }
    
    func setAllIdentifiers() {
        guard let viewModel = self.getViewModel() else { return }
    
        heroImageView?.accessibilityIdentifier = viewModel.getIdentifier(for: .heroImage)
        heroNameLabel?.accessibilityIdentifier = viewModel.getIdentifier(for: .heroName)
        heroPublisherNameLabel?.accessibilityIdentifier = viewModel.getIdentifier(for: .heroPublisher)
        heroDescriptionTextView?.accessibilityIdentifier = viewModel.getIdentifier(for: .heroDescription)
        favoriteButton?.accessibilityIdentifier  = viewModel.getIdentifier(for: .favoriteButton)
        shareBarButtonItem?.accessibilityIdentifier  = viewModel.getIdentifier(for: .shareButton)
    }
}
