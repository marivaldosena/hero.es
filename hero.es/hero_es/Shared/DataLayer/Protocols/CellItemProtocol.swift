//
//  ItemWithImageProtocol.swift
//  hero_es
//
//  Created by Marivaldo Sena on 01/01/21.
//

import Foundation

protocol CellItemProtocol: ItemProtocol {
    var thumbnailString: String { get set }
    var description: String { get set }
}
