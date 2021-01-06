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
    
    func save(_ model: FavoriteModel) {
        if find(id: model.id) != nil {
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
        var modelsArray: [FavoriteModel] = []
        var entitiesArray: [FavoriteEntity] = []
        
        do {
            let request: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
            
            if let term = term {
                request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", term)
            }
            
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
        var model: FavoriteModel? = nil
        var entitiesArray: [FavoriteEntity] = []
        
        do {
            let request: NSFetchRequest = FavoriteEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %i", id)
            request.fetchLimit = 1
            
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
