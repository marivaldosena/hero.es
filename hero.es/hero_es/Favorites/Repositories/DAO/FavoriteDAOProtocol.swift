//
//  FavoriteDAOProtocol.swift
//  hero_es
//
//  Created by Marivaldo Sena on 18/01/21.
//

import Foundation

protocol FavoriteDAOProtocol {
    associatedtype Model = FavoriteModel
    func save(_ model: Model, userId: String)
    func find(term: String?, userId: String, itemType: SearchItemType, limit: Int, offset: Int) -> [Model]
    func find(id: Int, userId: String, itemType: SearchItemType) -> Model?
    func exists(id: Int, userId: String, itemType: SearchItemType) -> Bool
    func delete(id: Int, userId: String, itemType: SearchItemType)
    func isFavorite(id: Int, userId: String, itemType: SearchItemType) -> Bool
}
