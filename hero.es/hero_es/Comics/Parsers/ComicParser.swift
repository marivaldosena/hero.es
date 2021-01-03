//
//  ComicParser.swift
//  hero_es
//
//  Created by Marivaldo Sena on 31/12/20.
//

import Foundation
import SwiftyJSON

// MARK: - ComicParser
struct ComicParser {
    static func from(json: Data) -> [ComicModel] {
        var modelsArray: [ComicModel] = []
        
        if let json = try? JSON(json) {
            let jsonArray = json["data"]["results"].arrayValue
            
            for item in jsonArray {
                if let model = from(json: item) {
                    modelsArray.append(model)
                }
            }
        }
        
        return modelsArray
    }
    
    static func from(json: JSON) -> ComicModel? {
        var model: ComicModel? = nil
        
        let dateFormatter = DateFormatter()
        // "2019-08-21T17:11:27-0400"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let id: Int = json["id"].intValue
        let name: String = json["title"].stringValue
        let resourceURI: String = json["resourceURI"].stringValue
        let description: String = json["description"].stringValue
        let upc: String = json["upc"].stringValue
        let pageCount: Int = json["pageCount"].intValue
        
        let modifiedString = json["modified"].stringValue
        let modified: Date? = dateFormatter.date(from: modifiedString)
        
        let thumbnailPath: String = json["thumbnail"]["path"].stringValue
        let thumbnailExtension: String = json["thumbnail"]["extension"].stringValue
        let thumbnailString: String = "\(thumbnailPath).\(thumbnailExtension)"
        
        model = ComicModel(
            id: id,
            name: name,
            resourceURI: resourceURI,
            description: description,
            modified: modified,
            upc: upc,
            pageCount: pageCount,
            thumbnailString: thumbnailString
        )
        
        let relatedHeroes: [RelatedHeroModel] = RelatedHeroParser.from(
            json: json["characters"],
            comicId: model?.id ?? 0
        )
        let numberOfHeroes: Int = relatedHeroes.count
        
        model?.relatedHeroes = relatedHeroes
        model?.numberOfHeroes = numberOfHeroes
        
        return model
    }
    
    static func from(coreData entity: ComicEntity) -> ComicModel? {
        var model: ComicModel? = nil
        
        do {
            let id: Int = Int(entity.id)
            let name: String = entity.name ?? ""
            let resourceURI: String = entity.resourceURI ?? ""
            let description: String = entity.descriptionText ?? ""
            let modified: Date? = entity.modified
            let upc: String = entity.upc ?? ""
            let pageCount: Int = Int(entity.pageCount)
            let thumbnailString: String = entity.thumbnail ?? ""
            
            model = ComicModel(
                id: id,
                name: name,
                resourceURI: resourceURI,
                description: description,
                modified: modified,
                upc: upc,
                pageCount: pageCount,
                thumbnailString: thumbnailString
            )
        }
        
        return model
    }
}
