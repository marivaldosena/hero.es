//
//  Searchable.swift
//  hero.es
//
//  Created by Marivaldo Sena on 22/10/20.
//

import Foundation

protocol Searchable {
    func searchBy(term: String) -> Bool
}
