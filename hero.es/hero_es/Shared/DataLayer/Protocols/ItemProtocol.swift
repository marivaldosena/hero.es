//
//  ItemProtocol.swift
//  hero.es
//
//  Created by Marivaldo Sena on 22/10/20.
//

import Foundation

// MARK: - ItemProtocol: Searchable
protocol ItemProtocol: Searchable {
    var name: String { get set }
    var resourceURI: String { get set }
}

// MARK: - ItemProtocol
extension ItemProtocol {
    func searchBy(term: String) -> Bool {
        return self.name.lowercased().contains(term.lowercased())
    }
}
