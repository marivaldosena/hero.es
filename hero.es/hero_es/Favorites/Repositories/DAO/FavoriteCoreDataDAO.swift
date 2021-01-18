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
        save(model, userId: "")
    }
    
    func save(_ model: FavoriteModel, userId: String) {
        if exists(model, userId: userId) {
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
            entity.userId = userId
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func find(term: String? = nil, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        return find(term: term, userId: "", itemType: .all, limit: limit, offset: offset)
    }
    
    func find(term: String? = nil, userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        var modelsArray: [FavoriteModel] = []
        var entitiesArray: [FavoriteEntity] = []
        
        do {
            entitiesArray = find(term: term, userId: userId, itemType: itemType, limit: limit, offset: offset)
            modelsArray = FavoriteParser.from(entitiesArray)
        } catch {
            print(error.localizedDescription)
        }
        
        return modelsArray
    }
    
    func find(term: String? = nil, userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0) -> [FavoriteEntity] {
        var entitiesArray: [FavoriteEntity] = []
        
        do {
            let request: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
            
            request.predicate = getPredicates(term: term, userId: userId, itemType: itemType)
            
            if limit != 0 {
                request.fetchLimit = limit
            }
            
            request.fetchOffset = offset
            entitiesArray = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        return entitiesArray
    }
    
    func find(id: Int) -> FavoriteModel? {
        return find(id: id, userId: "", itemType: .all)
    }
    
    func find(id: Int, userId: String, itemType: SearchItemType = .all) -> FavoriteModel? {
        var model: FavoriteModel? = nil
        
        do {
            if let entity: FavoriteEntity = find(id: id, userId: userId, itemType: itemType) {
                model = FavoriteParser.from(entity)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
    
    func find(id: Int, userId: String, itemType: SearchItemType = .all) -> FavoriteEntity? {
        var entitiesArray: [FavoriteEntity] = []
        
        do {
            let request: NSFetchRequest = FavoriteEntity.fetchRequest()
            
            request.fetchLimit = 1
            request.predicate = getPredicates(id: id, userId: userId, itemType: itemType)
        
            entitiesArray = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        if entitiesArray.count > 0 {
            return entitiesArray[0]
        }
        
        return nil
    }
    
    func exists(_ model: FavoriteModel, userId: String) -> Bool {
        return exists(id: model.id, userId: userId, itemType: getItemType(of: model))
    }
    
    func exists(id: Int, userId: String, itemType: SearchItemType = .hero) -> Bool {
        if let _: FavoriteModel =  find(id: id, userId: userId, itemType: itemType) {
            return true
        }
        return false
    }
    
    func delete(_ model: FavoriteModel, userId: String) {
        if !exists(model, userId: userId) {
            return
        }
        
        delete(id: model.id, userId: userId, itemType: getItemType(of: model))
    }
    
    func delete(id: Int, userId: String, itemType: SearchItemType = .all) {
        if !exists(id: id, userId: userId, itemType: itemType) {
            return
        }

        do {
            let request: NSFetchRequest<FavoriteEntity> =  FavoriteEntity.fetchRequest()
            request.fetchLimit = 1
            request.predicate = getPredicates(id: id, userId: userId, itemType: itemType)
            
            let entitiesArray: [FavoriteEntity] = try context.fetch(request)
            
            for entity in entitiesArray {
                context.delete(entity)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isFavorite(_ model: FavoriteModel, userId: String) -> Bool {
        if let _: FavoriteModel = find(id: model.id, userId: userId, itemType: getItemType(of: model)) {
            return true
        }
        return false
    }
    
    func isFavorite(id: Int, userId: String, itemType: SearchItemType = .all) -> Bool {
        if let _: FavoriteModel = find(id: id, userId: userId, itemType: itemType) {
            return true
        }
        return false
    }
    
    // MARK: - Private Methods
    private func getPredicates(id: Int? = nil, term: String? = nil, userId: String, itemType: SearchItemType = .all) -> NSCompoundPredicate {
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
        
        predicates.append(NSPredicate(format: "userId == %@", userId))
        
        let result = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        return result
    }
    
    private func getItemType(of model: FavoriteModel) -> SearchItemType {
        switch model.itemType {
        case .comic: return .comic
        default: return .hero
        }
    }
}
