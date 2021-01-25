//
//  FavoriteParser.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import Foundation
import Firebase

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
            print("DEBUG: FavoriteParser.from - \(error.localizedDescription)")
        }
        
        return model
    }
    
    static func from(_ item: CellItemProtocol, itemType: SearchItemType? = nil) -> FavoriteModel? {
        let favoriteItemType: ItemType = getItemType(of: itemType)
        var model: FavoriteModel? = nil
        
        do {
            model = FavoriteModel(
                id: item.id,
                itemType: favoriteItemType,
                name: item.name,
                resourceURI: item.resourceURI,
                thumbnailString: item.thumbnailString,
                description: item.description
            )
        } catch {
            print("DEBUG: FavoriteParser.from - \(error.localizedDescription)")
        }
        
        return model
    }
     
    static func from(_ array: [QueryDocumentSnapshot]) -> [FavoriteModel] {
        var modelsArray: [FavoriteModel] = []
        
        for item in array {
            if let model = from(item) {
                modelsArray.append(model)
            }
        }
        
        return modelsArray
    }
    
    static func from(_ item: QueryDocumentSnapshot) -> FavoriteModel? {
        return from(item.data())
    }
    
    static func from(_ item: [String: Any]) -> FavoriteModel? {
        var model: FavoriteModel? = nil
        
        do {
            let id = item["id"] as! Int
            let itemType = getItemType(of: item["itemType"])
            let name = item["name"] as! String
            let description = item["description"] as! String
            let resourceURI = item["resourceURI"] as! String
            let thumbnail = item["thumbnail"] as! String
            
            model = FavoriteModel(
                id: id,
                itemType: itemType,
                name: name,
                resourceURI: resourceURI,
                thumbnailString: thumbnail,
                description: description
            )
        } catch {
            print("DEBUG: FavoriteParser.from - \(error.localizedDescription)")
        }
        
        return model
    }
    
    // MARK: - Private Methods
    private static func getItemType(of item: CellItemProtocol, itemType: SearchItemType? = nil) -> ItemType {
        let favoriteItemType: ItemType
        
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
        
        return favoriteItemType
    }
    
    private static func getItemType(of item: Any?) -> ItemType {
        do {
            let itemString = item as? String ?? ""
            
            switch itemString {
            case "Comic": return .comic
            default: return .hero
            }
        } catch {
            print("DEBUG: FavoriteParser.getItemType - \(error.localizedDescription)")
        }
        return .hero
    }
}
