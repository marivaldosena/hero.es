//
//  ItemProtocol.swift
//  hero.es
//
//  Created by Marivaldo Sena on 22/10/20.
//

import Foundation

protocol ItemProtocol: Searchable {
    var name: String { get set }
    var resourceURI: String { get set }
}
