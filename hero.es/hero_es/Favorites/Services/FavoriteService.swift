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
        
    }
    
    func getItems(itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        guard let userId = getUserId() else { return [] }
        if persistentMethod != .online {
            return repository.find(userId: userId, itemType: itemType, limit: limit, offset: offset, in: persistentMethod)
        }
        return []
    }
    
    func find(id: Int, itemType: SearchItemType = .all, in persistentMethod: PersistentMethodEnum = .coreData) -> FavoriteModel? {
        // TODO: Implement online version.
        guard let userId = getUserId() else { return nil }
        if persistentMethod != .online {
            return repository.find(id: id, userId: userId, itemType: itemType, in: persistentMethod)
        }
        return nil
    }
    
    func find(itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        guard let userId = getUserId() else { return [] }
        if persistentMethod != .online {
            return repository.find(userId: userId, itemType: itemType, limit: limit, offset: offset, in: persistentMethod)
        }
        return []
    }
        
    func find(term: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement online version.
        guard let userId = getUserId() else { return [] }
        if persistentMethod != .online {
            return repository.find(term: term, userId: userId, itemType: itemType, limit: limit, offset: offset, in: persistentMethod)
        }
        return []
    }
    
    func save(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        // TODO: Implement online version.
        guard let userId = getUserId() else { return }
        if persistentMethod != .online {
            repository.save(model, userId: userId, in: persistentMethod)
        }
    }
    
    func save(_ array: [FavoriteModel], userId: String, in persistentMethod: PersistentMethodEnum = .coreData) {
        for item in array {
            save(item, in: persistentMethod)
        }
    }
    
    func delete(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        // TODO: Implement online version.
        guard let userId = getUserId() else { return }
        if persistentMethod != .online {
            repository.delete(model, userId: userId, in: persistentMethod)
        }
    }
    
    func toggleFavorite(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        guard let userId = getUserId() else { return }
        if isFavorite(model, userId: userId, in: persistentMethod) {
            deleteFavorite(model, userId: userId, in: persistentMethod)
        } else {
            addFavorite(model, userId: userId, in: persistentMethod)
        }
    }
    
    func toggleFavorite(_ item: CellItemProtocol, itemType: SearchItemType? = nil, in persistentMethod: PersistentMethodEnum = .coreData) {
        if isFavorite(item, itemType: itemType, in: persistentMethod) {
            deleteFavorite(item, itemType: itemType, in: persistentMethod)
        } else {
            addFavorite(item, itemType: itemType, in: persistentMethod)
        }
    }
    
    func isFavorite(_ model: FavoriteModel, userId: String, in persistentMethod: PersistentMethodEnum = .coreData) -> Bool {
        // TODO: Implement online functionality.
        guard let userId = getUserId() else { return false }
        if persistentMethod != .online {
            return repository.isFavorite(model, userId: userId, in: persistentMethod)
        }
        return false
    }
    
    func isFavorite(_ item: CellItemProtocol, itemType: SearchItemType? = nil, in persistentMethod: PersistentMethodEnum = .coreData) -> Bool {
        guard let userId = getUserId() else { return false }
        if persistentMethod != .online {
            guard let model = FavoriteParser.from(item, itemType: itemType) else {
                return false
            }
            return repository.isFavorite(model, userId: userId, in: persistentMethod)
        }
        return false
    }
    
    // MARK: - Private Methods
    private func getUserId() -> String? {
        guard let authCredentials = AuthService.shared.getCurrentUser() else { return nil }
        return authCredentials.userId
    }
    
    private func addFavorite(_ item: CellItemProtocol, itemType: SearchItemType? = nil, in persistentMethod: PersistentMethodEnum = .coreData) {
        guard let model = FavoriteParser.from(item, itemType: itemType) else { return }
        save(model, in: persistentMethod)
    }
    
    private func addFavorite(_ model: FavoriteModel, userId: String, in persistentMethod: PersistentMethodEnum = .coreData) {
        save(model, in: persistentMethod)
    }
    
    private func deleteFavorite(_ item: CellItemProtocol, itemType: SearchItemType? = nil, in persistentMethod: PersistentMethodEnum = .coreData) {
        guard let model = FavoriteParser.from(item, itemType: itemType) else { return }
        deleteFavorite(model, in: persistentMethod)
    }
    
    private func deleteFavorite(_ model: FavoriteModel, userId: String, in persistentMethod: PersistentMethodEnum = .coreData) {
        delete(model, in: persistentMethod)
    }
}
