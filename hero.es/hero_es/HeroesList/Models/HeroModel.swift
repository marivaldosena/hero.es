//
//  HeroModel.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation

struct HeroModel: ItemProtocol {
    var id: Int
    var name: String
    var description: String
    var modified: String
    var thumbnail: ThumbnailModel
    var resourceURI: String
    var numberOfComics: Int = 0
    var relatedComics: [RelatedComicModel] = []
//    let comics, series: Comics
//    let stories: Stories
//    let events: Comics
//    let urls: [URLElement]
    
    func searchBy(term: String) -> Bool {
        return self.name.lowercased().contains(term.lowercased())
    }
}
