//
//  RelatedHeroParser.swift
//  hero_es
//
//  Created by Marivaldo Sena on 03/01/21.
//

import Foundation
import SwiftyJSON

struct RelatedHeroParser {
    static func from(json: JSON, comicId: Int) -> [RelatedHeroModel] {
        var modelsArray: [RelatedHeroModel] = []
        let jsonArray = json["items"].arrayValue
        
        for item in jsonArray {
            if let model = from(json: item, comicId: comicId) {
                modelsArray.append(model)
            }
        }
        
        return modelsArray
    }
    
    static func from(json: JSON, comicId: Int = 0) -> RelatedHeroModel? {
        var model: RelatedHeroModel? = nil
        
        let name: String = json["name"].stringValue
        let resourceURI: String = json["resourceURI"].stringValue
        let id: Int = ModelUtils.getId(resourceURI: resourceURI)
        
        model = RelatedHeroModel(
            id: id,
            comicId: comicId,
            name: name,
            resourceURI: resourceURI
        )
        
        return model
    }
    
    static func from(coreData entity: RelatedHeroEntity) -> RelatedHeroModel? {
        var model: RelatedHeroModel? = nil
        
        let id: Int = Int(entity.id)
        let name: String = entity.name ?? ""
        let resourceURI: String = entity.resourceURI ?? ""
        let comicId: Int = Int(entity.comicId)
        
        model = RelatedHeroModel(
            id: id,
            comicId: comicId,
            name: name,
            resourceURI: resourceURI
        )
        
        return model
    }
    
    
}
