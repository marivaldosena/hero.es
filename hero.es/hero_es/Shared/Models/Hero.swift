//
//  Hero.swift
//  hero.es
//
//  Created by Marivaldo Sena on 22/10/20.
//

import Foundation

//MARK: - Hero
struct Hero: ItemProtocol {
    var id: Int
    var name: String
    var resourceURI: String
    var imageName: String
    var description: String
    var numberOfComics: Int
    
    init(id: Int, name: String, resourceURI: String, imageName: String, description: String, numberOfComics: Int) {
        self.id = id
        self.name = name
        self.resourceURI = resourceURI
        self.imageName = imageName
        self.description = description
        self.numberOfComics = numberOfComics
    }
    
    func searchBy(term: String) -> Bool {
        return self.name.lowercased().contains(term.lowercased())
    }
}
