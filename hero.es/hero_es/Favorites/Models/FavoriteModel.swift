//
//  FavoriteModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import Foundation

struct FavoriteModel: CellItemProtocol {
    var id: Int
    var itemType: ItemType
    var name: String
    var resourceURI: String
    var thumbnailString: String
    var description: String
}
