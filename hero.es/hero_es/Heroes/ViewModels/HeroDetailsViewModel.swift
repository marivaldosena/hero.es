//
//  HeroDetailsViewModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 26/12/20.
//

import Foundation
import UIKit

enum HeroDetailsUIIdentifier: String {
    case heroImage = "HeroImage"
    case heroName = "HeroName"
    case heroPublisher = "HeroPublisher"
    case heroDescription = "HeroDescription"
    case shareButton = "ShareButton"
    case favoriteButton = "FavoriteButton"
}

protocol HeroDetailsDelegate: class {
    func heroItemDidSelect(_ item: HeroModel)
}

struct HeroDetailsViewModel {
    private var model: HeroModel?
    weak var delegate: HeroDetailsDelegate?
    
    init(with model: HeroModel?) {
        self.model = model
    }
    
    func getName() -> String {
        return model?.name ?? "Unknown Hero"
    }
    
    func getDescription(_ gibberishIfEmpty: Bool = true) -> String {
        var description = model?.description ?? ""
        
        if gibberishIfEmpty == true && description.isEmpty {
            description = """
            We have no words to say about this incredible hero! Literally.
            Maybe some gibberish may help to fill the void we left.
            
            Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
            """
        }
        
        return description
    }
    
    func getImageUrlString() -> String {
        return model?.thumbnailString ?? "HeroImage"
    }
    
    func getImageUrl() -> URL? {
        return model?.getImageUrl()
    }
    
    func getImage() -> UIImage? {
        return model?.getImage()
    }
    
    func getPublisherName() -> String {
        // TODO: Refactor to use real publisher's name
        return "Marvel"
    }
    
    func isFavorite() -> Bool {
        return false
    }
    
    func getModel() -> HeroModel? {
        return self.model
    }
    
    func getUrlString() -> String {
        return self.model?.resourceURI ?? ""
    }
    
    func getUrl() -> URL? {
        guard let url = URL(string: self.getUrlString()) else { return nil }
        
        return url
    }
    
    func getNumberOfComics() -> Int {
        return model?.numberOfComics ?? 0
    }
    
    func getRelatedComics() -> [RelatedComicModel] {
        return model?.relatedComics ?? []
    }
    
    func getIdentifier(for view: HeroDetailsUIIdentifier) -> String {
        return view.rawValue
    }
}
