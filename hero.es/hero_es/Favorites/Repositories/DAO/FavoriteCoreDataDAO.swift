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
        if model.itemType == .comic {
            if find(id: model.id, itemType: .comic) != nil {
                return
            }
        } else {
            if find(id: model.id, itemType: .hero) != nil {
                return
            }
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
    
    func find(term: String? = nil, itemType: SearchItemType = .all,limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        var modelsArray: [FavoriteModel] = []
        var entitiesArray: [FavoriteEntity] = []
        var predicates: [NSPredicate] = []
        
        do {
            let request: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
            
            if let term = term {
                predicates.append(NSPredicate(format: "name CONTAINS[cd] %@", term))
            }
            
            if itemType != .all {
                predicates.append(NSPredicate(format: "itemType MATCHES[cd] %@", "\(itemType)"))
            }
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            
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
        var predicates: [NSPredicate] = []
        
        do {
            let request: NSFetchRequest = FavoriteEntity.fetchRequest()
            
            if itemType != .all {
                predicates.append(NSPredicate(format: "itemType MATCHES[cd] %@", "\(itemType)"))
            }
            
            predicates.append(NSPredicate(format: "id == %i", id))
            request.fetchLimit = 1
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            
            entitiesArray = try context.fetch(request)
            
            if entitiesArray.count > 0 {
                model = FavoriteParser.from(entitiesArray[0])
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
}
