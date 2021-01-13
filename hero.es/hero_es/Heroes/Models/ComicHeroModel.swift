//
//  ComicHeroModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 19/12/20.
//

import Foundation

struct ComicHeroModel {
    let heroId: Int
    let comicId: Int
    
    init(heroId: Int, comicId: Int) {
        self.heroId = heroId
        self.comicId = comicId
    }
}
