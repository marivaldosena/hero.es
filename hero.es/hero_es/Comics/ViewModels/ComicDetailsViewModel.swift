//
//  ComicDetailsViewModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import Foundation
import UIKit

struct ComicDetailsViewModel {
    let model: ComicModel
    
    init(with model: ComicModel) {
        self.model = model
    }
    
    func getModel() -> ComicModel {
        return model
    }
    
    func getName() -> String {
        return model.name
    }
    
    func getDescription(_ withGibberishIfEmpty: Bool = false) -> String {
        let description: String
        
        if withGibberishIfEmpty {
            description = "Sorry, something went wrong the description. Maybe the Publisher has forgotten to implement it!"
        } else {
            description = model.description
        }
        
        return description
    }
    
    func getImage() -> UIImage? {
        return model.getImage()
    }
    
    func getImageUrl() -> URL? {
        return model.getImageUrl()
    }
    
    func getImageUrlString() -> String {
        return model.thumbnailString
    }
    
    func getPublisherName() -> String {
        return "Marvel"
    }
    
    func getRelatedHeroes() -> [RelatedHeroModel] {
        return model.relatedHeroes
    }
    
    func getPageCount() -> Int {
        return model.pageCount
    }
    
    func getPageCountFormattedString() -> NSAttributedString {
        let stringValue = getPageCount() != 0 ? "\(getPageCount())" : "N/A"
        return getFormattedString(caption: "Page Count: ", value: stringValue)
    }
    
    func getUpc() -> String {
        return model.upc
    }
    
    func getUpcFormattedString() -> NSAttributedString {
        let stringValue = getUpc() != "" ? getUpc() : "N/A"
        return getFormattedString(caption: "UPC: ", value: stringValue)
    }
    
    func getFormattedString(caption: String, value: Any) -> NSAttributedString {
        let formattedString = NSMutableAttributedString()
        
        let captionText = NSMutableAttributedString(
            string: caption,
            attributes: [.foregroundColor: StyleGuide.Label.labelsDescription]
        )
        let valueText = NSAttributedString(
            string: "\(value)",
            attributes: [.foregroundColor: StyleGuide.Label.labelsDescription]
        )
        
        formattedString.append(captionText)
        formattedString.append(valueText)
        
        return formattedString
    }
}
