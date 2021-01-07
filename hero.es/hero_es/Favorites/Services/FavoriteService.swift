//
//  FavoriteService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import Foundation
import Firebase

// TODO: Refactor ServiceProtocol
struct FavoriteService {
    static var shared = FavoriteService()
    private let repository = FavoriteRepository.shared
    
    // MARK: - Public Methods
    func loadItems(completion: @escaping ([FavoriteModel]?, Error?) -> Void) {
        // TODO: Implement this.
    }
    
    func getItems(limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        switch persistentMethod {
        case .coreData:
            return getItems(itemType: .all, limit: limit, offset: offset, in: persistentMethod)
        default:
            return []
        }
    }
    
    func getItems(itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        switch persistentMethod {
        case .coreData:
            return find(itemType: itemType, limit: limit, offset: offset, in: persistentMethod)
        default:
            return []
        }
    }
    
    func find(id: Int, in persistentMethod: PersistentMethodEnum = .coreData) -> FavoriteModel? {
        // TODO: Implement online version.
        switch persistentMethod {
        case .coreData: return find(id: id, itemType: .all, in: persistentMethod)
        default: return nil
        }
    }
    
    func find(id: Int, itemType: SearchItemType = .all, in persistentMethod: PersistentMethodEnum = .coreData) -> FavoriteModel? {
        // TODO: Implement online version.
        switch persistentMethod {
        case .coreData: return findOneInCoreData(id: id, itemType: itemType)
        default: return nil
        }
    }
    
    func find(limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        switch persistentMethod {
        case .coreData:
            return find(itemType: .all, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func find(itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        switch persistentMethod {
        case .coreData:
            return findInCoreData(term: nil, itemType: itemType, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func find(term: String, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        switch persistentMethod {
        case .coreData:
            return find(term: term, itemType: .all, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func find(term: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        switch persistentMethod {
        case .coreData:
            return findInCoreData(term: term, itemType: itemType, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func save(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        // TODO: Implement online version.
        switch persistentMethod {
        case .coreData:
            saveInCoreData(model)
        default: break
        }
    }
    
    func addFavorite(item: CellItemProtocol, itemType: SearchItemType = .hero, in persistentMethod: PersistentMethodEnum = .coreData) {
        let favoriteType: ItemType
        
        switch itemType {
        case .comic:
            favoriteType = .comic
        default:
            favoriteType = .hero
        }
        
        let model = FavoriteModel(
            id: item.id,
            itemType: favoriteType,
            name: item.name,
            resourceURI: item.resourceURI,
            thumbnailString: item.thumbnailString,
            description: item.description
        )
        
        save(model, in: persistentMethod)
    }
    
    func removeFavorite(item: CellItemProtocol, itemType: SearchItemType = .hero, in persistentMethod: PersistentMethodEnum = .coreData) {
        
    }
    
    func save(_ array: [FavoriteModel], in persistentMethod: PersistentMethodEnum = .coreData) {
        for item in array {
            save(item, in: persistentMethod)
        }
    }
    
    // MARK: - Private Methods
    private func saveInCoreData(_ model: FavoriteModel) {
        repository.save(model, in: .coreData)
    }
    
    private func findInCoreData(term: String? = nil, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        if let term = term {
            return repository.find(term: term, itemType: itemType, limit: limit, offset: offset, in: .coreData)
        }
        
        return repository.find(itemType: itemType, limit: limit, offset: offset, in: .coreData)
    }
    
    private func findOneInCoreData(id: Int, itemType: SearchItemType = .all) -> FavoriteModel? {
        return repository.find(id: id, itemType: itemType, in: .coreData)
    }
}
