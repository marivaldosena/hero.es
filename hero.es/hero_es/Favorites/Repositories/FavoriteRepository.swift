//
//  FavoriteRepository.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//
import Foundation

// MARK: - FavoriteRepository
struct FavoriteRepository {
    // MARK: - Private Properties
    static var shared = FavoriteRepository()
    private let container = DBManager.shared.getContainer()
    private let favoriteCoreDataDAO: FavoriteCoreDataDAO
    private let favoriteFirebaseDAO: FavoriteFirebaseDAO
    
    private init() {
        favoriteCoreDataDAO = FavoriteCoreDataDAO(container: container)
        favoriteFirebaseDAO = FavoriteFirebaseDAO.shared
    }
    
    // MARK: - Public Methods
    func find(userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        switch persistentMethod {
        case .coreData: return findInCoreData(userId: userId, itemType: itemType, limit: limit, offset: offset)
        case .firebase: return findInFirebase(userId: userId, itemType: itemType, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func find(id: Int, userId: String, itemType: SearchItemType = .all, in persistentMethod: PersistentMethodEnum = .coreData) -> FavoriteModel? {
        switch persistentMethod {
        case .coreData: return findOneInCoreData(id: id, userId: userId, itemType: itemType)
        case .firebase: return findOneInFirebase(id: id, userId: userId, itemType: itemType)
        default: return nil
        }
    }
    
    func find(term: String, userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        switch persistentMethod {
        case .coreData: return findInCoreData(term: term, userId: userId, itemType: itemType, limit: limit, offset: offset)
        case .firebase: return findInFirebase(term: term, userId: userId, itemType: itemType, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func save(_ model: FavoriteModel, userId: String, in persistentMethod: PersistentMethodEnum = .coreData) {
        switch persistentMethod {
        case .coreData: saveInCoreData(model, userId: userId)
        case .firebase: saveInFirebase(model, userId: userId)
        default: break
        }
    }
    
    func save(_ array: [FavoriteModel], userId: String, in persistentMethod: PersistentMethodEnum = .coreData) {
        for item in array {
            save(item, userId: userId, in: persistentMethod)
        }
    }
    
    func delete(_ array: [FavoriteModel], userId: String, in persistentMethod: PersistentMethodEnum = .coreData) {
        for item in array {
            delete(item, userId: userId, in: persistentMethod)
        }
    }
    
    func delete(_ model: FavoriteModel, userId: String, in persistentMethod: PersistentMethodEnum = .coreData) {
        switch persistentMethod {
        case .coreData: deleteInCoreData(model, userId: userId)
        case .firebase: deleteInFirebase(model, userId: userId)
        default: break
        }
    }
    
    func delete(id: Int, userId: String, itemType: SearchItemType = .hero, in persistentMethod: PersistentMethodEnum = .coreData) {
        switch persistentMethod {
        case .coreData: deleteInCoreData(id: id, userId: userId, itemType: itemType)
        case .firebase: deleteInFirebase(id: id, userId: userId, itemType: itemType)
        default: break
        }
    }
    
    func isFavorite(_ model: FavoriteModel, userId: String, in persistentMethod: PersistentMethodEnum = .coreData) -> Bool {
        switch persistentMethod {
        case .coreData: return isFavoriteInCoreData(model, userId: userId)
        case .firebase: return isFavoriteInFirebase(model, userId: userId)
        default: return false
        }
    }
    
    func isFavorite(id: Int, userId: String, itemType: SearchItemType = .hero, in persistentMethod: PersistentMethodEnum = .coreData) -> Bool {
        switch persistentMethod {
        case .coreData: return isFavoriteInCoreData(id: id, userId: userId, itemType: itemType)
        case .firebase: return isFavoriteInFirebase(id: id, userId: userId, itemType: itemType)
        default: return false
        }
    }
    
    // MARK: - Private Methods
    // MARK: - Core Data
    private func findInCoreData(
        term: String? = nil,
        userId: String,
        itemType: SearchItemType = .all,
        limit: Int = 0,
        offset: Int = 0
    ) -> [FavoriteModel] {
        if let term = term {
            return favoriteCoreDataDAO.find(
                term: term,
                userId: userId,
                itemType: itemType,
                limit: limit,
                offset: offset
            )
        }
        
        return favoriteCoreDataDAO.find(userId: userId, itemType: itemType, limit: limit, offset: offset)
    }
    
    private func findOneInCoreData(id: Int, userId: String, itemType: SearchItemType = .all) -> FavoriteModel? {
        return favoriteCoreDataDAO.find(id: id, userId: userId, itemType: itemType)
    }
    
    private func saveInCoreData(_ model: FavoriteModel, userId: String) {
        favoriteCoreDataDAO.save(model, userId: userId)
    }
    
    private func deleteInCoreData(_ model: FavoriteModel? = nil, id: Int? = nil, userId: String, itemType: SearchItemType = .hero) {
        if let model = model {
            favoriteCoreDataDAO.delete(model, userId: userId)
        }
        
        if let id = id {
            favoriteCoreDataDAO.delete(id: id, userId: userId, itemType: itemType)
        }
    }
    
    private func isFavoriteInCoreData(_ model: FavoriteModel? = nil, id: Int? = nil, userId: String, itemType: SearchItemType = .hero) -> Bool {
        if let id = id {
            return favoriteCoreDataDAO.isFavorite(id: id, userId: userId, itemType: itemType)
        }
        
        if let model = model {
            return favoriteCoreDataDAO.isFavorite(model, userId: userId)
        }
        
        return false
    }
    
    // MARK: - Firebase
    private func findInFirebase(term: String? = nil, userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        return favoriteFirebaseDAO.find(term: term, userId: userId, itemType: itemType, limit: limit, offset: offset)
    }
    
    private func findOneInFirebase(id: Int, userId: String, itemType: SearchItemType = .all) -> FavoriteModel? {
        return favoriteFirebaseDAO.find(id: id, userId: userId, itemType: itemType)
    }
    
    private func saveInFirebase(_ model: FavoriteModel, userId: String) {
        favoriteFirebaseDAO.save(model, userId: userId)
    }
    
    private func deleteInFirebase(_ model: FavoriteModel? = nil, id: Int? = nil, userId: String, itemType: SearchItemType = .hero) {
        if let model = model {
            favoriteFirebaseDAO.delete(id: model.id, userId: userId, itemType: model.itemType.getSearchItemType())
        }
        
        if let id = id {
            favoriteFirebaseDAO.delete(id: id, userId: userId, itemType: itemType)
        }
    }
    
    private func isFavoriteInFirebase(_ model: FavoriteModel? = nil, id: Int? = nil, userId: String, itemType: SearchItemType = .hero) -> Bool {
        if let model = model {
            return favoriteFirebaseDAO.isFavorite(id: model.id, userId: userId, itemType: model.getSearchItemType())
        }
        
        return favoriteFirebaseDAO.isFavorite(id: id ?? 0, userId: userId, itemType: itemType)
    }
}
