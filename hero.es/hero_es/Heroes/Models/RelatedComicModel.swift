//
//  ComicModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 19/12/20.
//

import Foundation

struct RelatedComicModel {
    let id: Int
    let name: String
    let resourceURI: String
    
    init(id: Int, name: String, resourceURI: String) {
        self.id = id
        self.name = name
        self.resourceURI = resourceURI
    }
}
