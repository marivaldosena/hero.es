//
//  FavoriteCoreDataDAO.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import Foundation
import CoreData

struct FavoriteCoreDataDAO: CoreDataDAOProtocol {
    typealias Model = FavoriteModel
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.context = container.viewContext
    }
    
    
    // MARK: - Public Methods
    func save(_ model: FavoriteModel) {
        if exists(model) {
           return
        }
        
        do {
            let entity = FavoriteEntity(context: context)
            entity.id = Int64(model.id)
            entity.name = model.name
            entity.itemType = model.itemType.rawValue
            entity.resourceURI = model.resourceURI
            entity.thumbnail = model.thumbnailString
            entity.descriptionText = model.description
            
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func find(term: String? = nil, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        return find(term: term, itemType: .all, limit: limit, offset: offset)
    }
    
    func find(term: String? = nil, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        var modelsArray: [FavoriteModel] = []
        var entitiesArray: [FavoriteEntity] = []
        
        do {
            let request: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
            
            request.predicate = getPredicates(term: term, itemType: itemType)
            
            if limit != 0 {
                request.fetchLimit = limit
            }
            
            request.fetchOffset = offset
            entitiesArray = try context.fetch(request)
            modelsArray = FavoriteParser.from(entitiesArray)
        } catch {
            print(error.localizedDescription)
        }
        
        return modelsArray
    }
    
    func find(id: Int) -> FavoriteModel? {
        find(id: id, itemType: .all)
    }
    
    func find(id: Int, itemType: SearchItemType = .all) -> FavoriteModel? {
        var model: FavoriteModel? = nil
        var entitiesArray: [FavoriteEntity] = []
        
        do {
            let request: NSFetchRequest = FavoriteEntity.fetchRequest()
            
            request.fetchLimit = 1
            
            request.predicate = getPredicates(id: id, itemType: itemType)
            
            entitiesArray = try context.fetch(request)
            
            if entitiesArray.count > 0 {
                model = FavoriteParser.from(entitiesArray[0])
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
    
    func exists(_ model: FavoriteModel) -> Bool {
        if model.itemType == .comic {
            if exists(id: model.id, itemType: .comic) {
                return true
            }
        } else {
            if exists(id: model.id, itemType: .hero) {
                return true
            }
        }
        return false
    }
    
    func exists(id: Int, itemType: SearchItemType = .hero) -> Bool {
        return find(id: id, itemType: itemType) != nil
    }
    
//    func delete(id: Int, itemType: SearchItemType = .all) {
//        if !exists(id: id, itemType: itemType) {
//            return
//        }
//
//        context.delete(<#T##object: NSManagedObject##NSManagedObject#>)
//    }
    
    // MARK: - Private Methods
    private func getPredicates(id: Int? = nil, term: String? = nil, itemType: SearchItemType = .all) -> NSCompoundPredicate {
        var predicates: [NSPredicate] = []
        
        if itemType != .all {
            predicates.append(NSPredicate(format: "itemType MATCHES[cd] %@", "\(itemType)"))
        }
        
        if let term = term {
            predicates.append(NSPredicate(format: "name CONTAINS[cd] %@", term))
        }
        
        if let id = id {
            predicates.append(NSPredicate(format: "id == %i", id))
        }
        
        let result = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        return result
    }
}
