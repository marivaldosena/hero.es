//
//  SearchItemType.swift
//  hero_es
//
//  Created by Marivaldo Sena on 06/01/21.
//

import Foundation

enum SearchItemType {
    case all
    case hero
    case comic
}

extension SearchItemType {
    func getFirebaseItemTypeValues() -> [String] {
        switch self {
        case .comic:
            return ["Comic"]
        case .hero:
            return ["Hero"]
        default:
            return ["Comic", "Hero"]
        }
    }
}
