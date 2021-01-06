//
//  FavoriteViewModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 06/01/21.
//

import Foundation

struct FavoriteViewModel {
    private let service: FavoriteService = FavoriteService.shared
    
    func getItems(limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        return service.getItems(limit: limit, offset: offset, in: persistentMethod)
    }
    
    func search(term: String? = nil, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [FavoriteModel] {
        return service.find(term: term ?? "", limit: limit, offset: offset, in: persistentMethod)
    }
    
    func save() {
        
    }
}
