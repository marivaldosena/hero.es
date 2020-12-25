//
//  DataClass.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation

struct DataClass: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [HeroModel]
}
