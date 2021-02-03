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
            self.favoriteButton.setImage(viewModel.getLikeButtonImage(), for: .normal)
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

// MARK: - HeroDetailsViewController: ShareAndLikeItemProtocol
extension HeroDetailsViewController: ShareAndLikeItemProtocol {
    func share(item: CellItemProtocol?) {
        guard let item = item else { return }
        ShareItemUtils.share(item, on: self)
    }
    
    func like(item: CellItemProtocol?) {
        guard let item = item else { return }
        let service = FavoriteService.shared
        service.toggleFavorite(item, itemType: .hero, in: .firebase)
        updateUIInterface()
    }
}

// MARK: - HeroDetailsViewController: UpdateLanguageProtocol
extension HeroDetailsViewController: UpdateLanguageProtocol {
    func languageDidChange(_ language: AvailableLanguage) {
        updateUIInterface()
    }
}
