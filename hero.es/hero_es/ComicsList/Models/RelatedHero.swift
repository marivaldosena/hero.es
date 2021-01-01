//
//  RelatedHero.swift
//  hero_es
//
//  Created by Marivaldo Sena on 01/01/21.
//

import Foundation

struct RelatedHero: ItemProtocol {
    var id: Int
    var name: String
    var resourceURI: String
    
    func searchBy(term: String) -> Bool {
        return self.name.lowercased().contains(term.lowercased())
    }
    
    
}
