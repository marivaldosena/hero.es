//
//  ItemType.swift
//  hero_es
//
//  Created by Marivaldo Sena on 06/01/21.
//

import Foundation

enum ItemType: String {
    case hero = "Hero"
    case comic = "Comic"
}

extension ItemType {
    func getSearchItemType() -> SearchItemType {
        switch self {
        case .comic: return .comic
        default: return .hero
        }
    }
}
