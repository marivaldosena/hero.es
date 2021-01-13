//
//  HeroModel.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation

struct HeroModel: CellItemProtocol {
    var id: Int
    var name: String
    var description: String
    var modified: String
    var thumbnailString: String
    var resourceURI: String
    var numberOfComics: Int = 0
    var relatedComics: [RelatedComicModel] = []
    
    func searchBy(term: String) -> Bool {
        return self.name.lowercased().contains(term.lowercased())
    }
}
