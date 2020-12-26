//
//  CoreDataDAOProtocol.swift
//  hero_es
//
//  Created by Marivaldo Sena on 25/12/20.
//

import Foundation
import CoreData

protocol CoreDataDAOProtocol {
    associatedtype Model
    
    init(container: NSPersistentContainer)
    func save(_ model: Model)
    func find(term: String?, limit: Int, offset: Int) -> [Model]
    func find(id: Int) -> Model?
}
