//
//  FavoriteModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import Foundation

enum ItemType: String {
    case hero = "Hero"
    case comic = "Comic"
}

struct FavoriteModel: ItemProtocol {
    var id: Int
    var itemType: ItemType
    var name: String
    var resourceURI: String
    
    func searchBy(term: String) -> Bool {
        return  self.name.lowercased().contains(term.lowercased())
    }
}
