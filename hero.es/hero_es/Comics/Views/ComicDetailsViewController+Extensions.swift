//
//  ComicDetailsViewController+Extensions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import Foundation
import UIKit

// MARK: - ComicDetailsViewController
extension ComicDetailsViewController {
    func updateUIInterface() {
        let viewModel = getViewModel()
        title = viewModel?.getName() ?? "Details"
        
        DispatchQueue.main.async {
            self.imageView.image = viewModel?.getImage()
            self.comicNameLabel.text = viewModel?.getName()
            self.comicTypeLabel.text = viewModel?.getPublisherName()
            self.comicDescriptionTextView.text = viewModel?.getDescription(true)
            self.comicPageCountLabel.attributedText = viewModel?.getPageCountFormattedString()
            self.comicUpcLabel.attributedText = viewModel?.getUpcFormattedString()
        }
    }
    
    func share(_ item: ComicModel) {
        ShareItemUtils.share(item, on: self)
    }
}
