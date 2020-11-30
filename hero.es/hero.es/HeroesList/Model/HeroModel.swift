//
//  HeroModel.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation

struct HeroModel: Codable {
    let id: Double
    let name: String
    let description: String
    let modified: String
    let thumbnail: ThumbnailModel
    let resourceURI: String
//    let comics, series: Comics
//    let stories: Stories
//    let events: Comics
//    let urls: [URLElement]
    
    func searchBy(term: String) -> Bool {
        return self.name.lowercased().contains(term.lowercased())
    }
}
