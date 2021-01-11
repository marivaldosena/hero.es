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
    
    func getItems(itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        if persistentMethod != .online {
            return repository.find(itemType: itemType, limit: limit, offset: offset, in: persistentMethod)
        }
        return []
    }
    
    func find(id: Int, itemType: SearchItemType = .all, in persistentMethod: PersistentMethodEnum = .coreData) -> FavoriteModel? {
        // TODO: Implement online version.
        if persistentMethod != .online {
            return repository.find(id: id, itemType: itemType)
        }
        return nil
    }
    
    func find(itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        if persistentMethod != .online {
            return repository.find(itemType: itemType, limit: limit, offset: offset)
        }
        return []
    }
        
    func find(term: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        if persistentMethod != .online {
            return repository.find(term: term, itemType: itemType, limit: limit, offset: offset)
        }
        return []
    }
    
    func save(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        // TODO: Implement online version.
        if persistentMethod != .online {
            repository.save(model, in: persistentMethod)
        }
    }
    
    func delete(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        // TODO: Implement online version.
        if persistentMethod != .online {
            repository.delete(model)
        }
    }
    
    func addFavorite(_ item: CellItemProtocol, itemType: SearchItemType? = nil, in persistentMethod: PersistentMethodEnum = .coreData) {
        guard let model = FavoriteParser.from(item, itemType: itemType) else { return }
        
        save(model, in: persistentMethod)
    }
    
    func addFavorite(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        save(model, in: persistentMethod)
    }
    
    func deleteFavorite(_ item: CellItemProtocol, itemType: SearchItemType? = nil, in persistentMethod: PersistentMethodEnum = .coreData) {
        guard let model = FavoriteParser.from(item, itemType: itemType) else { return }
        deleteFavorite(model, in: persistentMethod)
    }
    
    func deleteFavorite(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        delete(model, in: persistentMethod)
    }
    
    func toggleFavorite(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        if isFavorite(model, in: persistentMethod) {
            deleteFavorite(model, in: persistentMethod)
        } else {
            addFavorite(model, in: persistentMethod)
        }
    }
    
    func toggleFavorite(_ item: CellItemProtocol, itemType: SearchItemType? = nil, in persistentMethod: PersistentMethodEnum = .coreData) {
        
        if isFavorite(item, itemType: itemType, in: persistentMethod) {
            deleteFavorite(item, itemType: itemType, in: persistentMethod)
        } else {
            addFavorite(item, itemType: itemType, in: persistentMethod)
        }
    }
    
    func isFavorite(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) -> Bool {
        // TODO: Implement online functionality.
        if persistentMethod != .online {
            return repository.isFavorite(model, in: persistentMethod)
        }
        return false
    }
    
    func isFavorite(_ item: CellItemProtocol, itemType: SearchItemType? = nil, in persistentMethod: PersistentMethodEnum = .coreData) -> Bool {
        if persistentMethod != .online {
            guard let model = FavoriteParser.from(item, itemType: itemType) else {
                return false
            }
            return repository.isFavorite(model, in: persistentMethod)
        }
        return false
    }
    
    func save(_ array: [FavoriteModel], in persistentMethod: PersistentMethodEnum = .coreData) {
        for item in array {
            save(item, in: persistentMethod)
        }
    }
}
