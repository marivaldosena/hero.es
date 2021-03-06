//
//  HeroParser.swift
//  hero_es
//
//  Created by Marivaldo Sena on 16/12/20.
//

import Foundation
import SwiftyJSON

struct HeroParser {
    let id: Double
    let name: String
    let description: String
    let modified: String
    let thumbnail: String
    let resourceURI: String
    
    static func from(json: Data) -> [HeroModel] {
        var modelsArray: [HeroModel] = []
        
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
    
    static func from(json: JSON) -> HeroModel? {
        var model: HeroModel? = nil
        var relatedComics: [RelatedComicModel] = []
        
        if let json = try? JSON(json) {
            let id = json["id"].intValue
            
            let name = json["name"].stringValue
            let description = json["description"].stringValue
            let resourceURI = json["resourceURI"].stringValue
            
            let modified = json["modified"].stringValue
            
            let thumbnailPath = json["thumbnail"]["path"].stringValue
            let thumbnailExtension = json["thumbnail"]["extension"].stringValue
            let thumbnail = "\(thumbnailPath).\(thumbnailExtension)"
            
            model = HeroModel(id: id,
                              name: name,
                              description: description,
                              modified: modified,
                              thumbnailString: thumbnail,
                              resourceURI: resourceURI)
            
            relatedComics = RelatedComicParser.from(json: json["comics"])
            let numberOfComics = relatedComics.count
            
            model?.numberOfComics = numberOfComics
            model?.relatedComics = relatedComics
        }
        
        return model
    }
    
    static func from(coreData entity: HeroEntity) -> HeroModel? {
        let model: HeroModel?
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZZZZZ"
            
            let id: Int = Int(entity.id)
            let name: String = entity.name ?? ""
            let description: String = entity.descriptionText ?? ""
            let modified: String
            
            if let modifiedDate = entity.modified {
                modified = dateFormatter.string(from: modifiedDate)
            } else {
                modified = ""
            }
            
            let thumbnail = entity.thumbnail ?? ""
            let resourceURI = entity.resourceURI ?? ""
            let numberOfComics: Int = Int(entity.numberOfComics)
            
            model = HeroModel(id: id,
                              name: name,
                              description: description,
                              modified: modified,
                              thumbnailString: thumbnail,
                              resourceURI: resourceURI,
                              numberOfComics: numberOfComics)
            
            
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
}
