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
        // TODO: Implement this.
        switch persistentMethod {
        case .coreData:
            return find(limit: limit, offset: offset, in: persistentMethod)
        default:
            return []
        }
    }
    
    func find(id: Int, in persistentMethod: PersistentMethodEnum = .coreData) -> FavoriteModel? {
        switch persistentMethod {
        case .coreData: return findOneInCoreData(id: id)
        default: return nil
        }
    }
    
    func find(limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement this.
        switch persistentMethod {
        case .coreData:
            return findInCoreData(term: nil, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func find(term: String, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        // TODO: Implement this.
        switch persistentMethod {
        case .coreData:
            return findInCoreData(term: term, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func save(_ model: FavoriteModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        // TODO: Implement this.
        switch persistentMethod {
        case .coreData:
            saveInCoreData(model)
        default: break
        }
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
    
    private func findInCoreData(term: String? = nil, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        if let term = term {
            return repository.find(term: term, limit: limit, offset: offset, in: .coreData)
        }
        
        return repository.find(limit: limit, offset: offset, in: .coreData)
    }
    
    private func findOneInCoreData(id: Int) -> FavoriteModel? {
        return repository.find(id: id, in: .coreData)
    }
}
