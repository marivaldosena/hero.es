//
//  FavoriteViewModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 06/01/21.
//

import Foundation

// MARK: - FavoriteViewModel
struct FavoritesViewModel {
    // MARK: - Private Properties
    private let service: FavoriteService = FavoriteService.shared
    private var modelsArray: [FavoriteModel] = []
    
    // MARK: - Public Methods
    mutating func getItems(itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        modelsArray = service.getItems(itemType: itemType, limit: limit, offset: offset, in: persistentMethod)
        return modelsArray
    }
    
    mutating func search(term: String? = nil, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        modelsArray = service.find(term: term ?? "", limit: limit, offset: offset, in: persistentMethod)
        return modelsArray
    }
    
    func getNumberOfItems() -> Int {
        return modelsArray.count
    }
    
    func getItem(at index: Int) -> FavoriteModel? {
        if isIndexValid(index: index) {
            return modelsArray[index]
        }
        return nil
    }
    
    // MARK: - Private Methods
    private func isIndexValid(index: Int) -> Bool {
        if index > 0 && index < modelsArray.count {
            return true
        }
        return false
    }
}
