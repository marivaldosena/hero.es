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
            return findInCoreData(limit: limit, offset: offset, in: persistentMethod)
        default: return []
        }
    }
    
    func find(id: Int, in persistentMethod: PersistentMethodEnum = .coreData) -> FavoriteModel? {
        switch persistentMethod {
        case .coreData: return findOneInCoreData(id: id)
        default: return nil
        }
    }
    
    func find(term: String, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        return findInCoreData(term: term, limit: limit, offset: offset, in: persistentMethod)
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
    private func findInCoreData(term: String? = nil, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        if let term = term {
            return favoriteCoreDataDAO.find(term: term, limit: limit, offset: offset)
        }
        
        return favoriteCoreDataDAO.find(limit: limit, offset: offset)
    }
    
    private func findOneInCoreData(id: Int) -> FavoriteModel? {
        return favoriteCoreDataDAO.find(id: id)
    }
    
    private func saveInCoreData(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        favoriteCoreDataDAO.save(model)
    }
}
