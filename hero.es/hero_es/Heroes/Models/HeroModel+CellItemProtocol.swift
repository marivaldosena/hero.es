//
//  HeroModel+CellItemProtocol.swift
//  hero_es
//
//  Created by Marivaldo Sena on 03/02/21.
//

import Foundation

extension HeroModel {
    func getCellItem() -> CellItemProtocol? {
        return self as? CellItemProtocol
    }
}
