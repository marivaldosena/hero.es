//
//  RelatedComicParser.swift
//  hero_es
//
//  Created by Marivaldo Sena on 25/12/20.
//

import Foundation
import SwiftyJSON

struct RelatedComicParser {
    
    static func from(json: JSON) -> [RelatedComicModel] {
        var modelsArray: [RelatedComicModel] = []
        let jsonArray = json["items"].arrayValue

        for item in jsonArray {
            if let model = from(json: item) {
                modelsArray.append(model)
            }
        }
        
        return modelsArray
    }
    
    static func from(json: JSON) -> RelatedComicModel? {
        var model: RelatedComicModel? = nil
        
        let name = json["name"].stringValue
        let resourceURI = json["resourceURI"].stringValue
        let id = getComicId(resourceURI: resourceURI)

        model = RelatedComicModel(id: id, name: name, resourceURI: resourceURI)
        
        return model
    }
    
    static func from(coreData entity: RelatedComicEntity) -> RelatedComicModel? {
        var model: RelatedComicModel? = nil
        
        let id: Int = Int(entity.id)
        let name: String = entity.name ?? ""
        let resourceURI: String = entity.resourceURI ?? ""
        
        model = RelatedComicModel(id: id, name: name, resourceURI: resourceURI)
        
        return model
    }
    
    static func from(coreData entity: ComicHeroEntity) -> ComicHeroModel? {
        var model: ComicHeroModel? = nil
        
        let heroId: Int = Int(entity.heroId)
        let comicId: Int = Int(entity.comicId)
        model = ComicHeroModel(heroId: heroId, comicId: comicId)
        
        return model
    }
    
    private static func getComicId(resourceURI: String) -> Int {
        let tokens = resourceURI.split(separator: "/")
        let id = Int(String(tokens[tokens.count - 1])) ?? 0
        
        return id
    }
}
