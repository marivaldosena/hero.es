//
//  HeroModel.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation

struct HeroModel: Codable {
    let id: Int
    let name: String
    let description: String
    let modified: Date
    let thumbnail: ThumbnailModel
    let resourceURI: String
//    let comics, series: Comics
//    let stories: Stories
//    let events: Comics
//    let urls: [URLElement]
}
