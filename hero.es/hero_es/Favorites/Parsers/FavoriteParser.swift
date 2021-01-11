//
//  FavoriteParser.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import Foundation

struct FavoriteParser {
    static func from(_ entities: [FavoriteEntity]) -> [FavoriteModel] {
        var modelsArray: [FavoriteModel] = []
        
        for entity in entities {
            if let model = from(entity) {
                modelsArray.append(model)
            }
        }
        
        return modelsArray
    }
    
    static func from(_ entity: FavoriteEntity) -> FavoriteModel? {
        var model: FavoriteModel? = nil
        
        do {
            let itemType: ItemType = ItemType(rawValue: entity.itemType!) ?? .hero
            
            model = FavoriteModel(
                id: Int(entity.id),
                itemType: itemType,
                name: entity.name ?? "",
                resourceURI: entity.resourceURI ?? "",
                thumbnailString: entity.thumbnail ?? "",
                description: entity.descriptionText ?? ""
            )
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
    
    static func from(_ item: CellItemProtocol, itemType: SearchItemType? = nil) -> FavoriteModel? {
        var favoriteItemType: ItemType
        
        if let itemType = itemType {
            if itemType == .comic {
                favoriteItemType = .comic
            } else {
                favoriteItemType = .hero
            }
        } else {
            if HeroService.shared.find(id: item.id) != nil {
                favoriteItemType = .hero
            } else {
                favoriteItemType = .comic
            }
        }
        
        let model = FavoriteModel(
            id: item.id,
            itemType: favoriteItemType,
            name: item.name,
            resourceURI: item.resourceURI,
            thumbnailString: item.thumbnailString,
            description: item.description
        )
        
        return model
    }
}
