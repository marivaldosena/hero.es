//
//  SeedProtocol.swift
//  hero.es
//
//  Created by Marivaldo Sena on 22/10/20.
//

import Foundation

protocol SeedProtocol {
    associatedtype Item
    
    static func seed() -> [Item]
}
