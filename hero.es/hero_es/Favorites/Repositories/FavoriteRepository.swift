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
    
    private init() {
        favoriteCoreDataDAO = FavoriteCoreDataDAO(container: container)
    }
    
    // MARK: - Public Methods
    func find(limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        switch persistentMethod {
        case .coreData:
            return find(itemType: .all, limit: limit, offset: offset, in: persistentMethod)
        default: return []
        }
    }
    
    func find(itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        switch persistentMethod {
        case .coreData:
            return findInCoreData(itemType: .all, limit: limit, offset: offset, in: persistentMethod)
        default: return []
        }
    }
    
    func find(id: Int, in persistentMethod: PersistentMethodEnum = .coreData) -> FavoriteModel? {
        switch persistentMethod {
        case .coreData: return find(id: id, itemType: .all, in: persistentMethod)
        default: return nil
        }
    }
    
    func find(id: Int, itemType: SearchItemType = .all, in persistentMethod: PersistentMethodEnum = .coreData) -> FavoriteModel? {
        switch persistentMethod {
        case .coreData: return findOneInCoreData(id: id, itemType: itemType)
        default: return nil
        }
    }
    
    func find(term: String, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        switch persistentMethod {
        case .coreData:
            return find(term: term, itemType: .all, limit: limit, offset: offset, in: persistentMethod)
        default: return []
        }
    }
    
    func find(term: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        switch persistentMethod {
        case .coreData:
            return findInCoreData(term: term, itemType: itemType, limit: limit, offset: offset, in: persistentMethod)
        default: return []
        }
    }
    
    func save(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        switch persistentMethod {
        case .coreData: saveInCoreData(model)
        default: break
        }
    }
    
    func save(_ array: [FavoriteModel], in persistentMethod: PersistentMethodEnum = .coreData) {
        for item in array {
            save(item, in: persistentMethod)
        }
    }
    
    // MARK: - Private Methods
    private func findInCoreData(
        term: String? = nil,
        itemType: SearchItemType = .all,
        limit: Int = 0,
        offset: Int = 0,
        in persistentMethod: PersistentMethodEnum = .coreData
    ) -> [FavoriteModel] {
        if let term = term {
            return favoriteCoreDataDAO.find(
                term: term,
                itemType: itemType,
                limit: limit,
                offset: offset
            )
        }
        
        return favoriteCoreDataDAO.find(itemType: itemType, limit: limit, offset: offset)
    }
    
    private func findOneInCoreData(id: Int, itemType: SearchItemType = .all) -> FavoriteModel? {
        return favoriteCoreDataDAO.find(id: id, itemType: itemType)
    }
    
    private func saveInCoreData(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        favoriteCoreDataDAO.save(model)
    }
}
