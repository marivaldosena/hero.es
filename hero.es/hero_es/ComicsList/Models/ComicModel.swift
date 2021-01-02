//
//  ComicModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 31/12/20.
//

import Foundation

struct ComicModel: CellItemProtocol {
    var id: Int
    var name: String
    var resourceURI: String
    var description: String
    var modified: Date?
    var upc: String
    var pageCount: Int
    var thumbnailString: String
    var relatedHeroes: [RelatedHero] = []
}
