//
//  HeroModel+Favorite.swift
//  hero_es
//
//  Created by Marivaldo Sena on 10/01/21.
//

import Foundation

extension CellItemProtocol {
    func isFavorite(itemType: SearchItemType? = nil, in persistentMethod: PersistentMethodEnum = .coreData) -> Bool {
        let service = FavoriteService.shared
        return service.isFavorite(self, itemType: itemType, in: persistentMethod)
    }
}
