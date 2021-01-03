//
//  ComicCoreDataDAO.swift
//  hero_es
//
//  Created by Marivaldo Sena on 02/01/21.
//

import Foundation
import CoreData

struct ComicCoreDataDAO: CoreDataDAOProtocol {
    typealias Model = ComicModel
    private var container: NSPersistentContainer
    private var context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.context = container.viewContext
    }
    
    func save(_ model: ComicModel) {
        do {
            if find(id: model.id) != nil {
                return
            }
            
            let entity = ComicEntity(context: context)
            entity.id = Int64(model.id)
            entity.name = model.name
            entity.resourceURI = model.resourceURI
            entity.descriptionText = model.description
            entity.modified = model.modified
            entity.upc = model.upc
            entity.pageCount = Int64(model.pageCount)
            entity.thumbnail = model.thumbnailString
            entity.numberOfHeroes = Int64(model.numberOfHeroes)
            
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func find(term: String? = nil, limit: Int = 0, offset: Int = 0) -> [ComicModel] {
        let request: NSFetchRequest<ComicEntity> = ComicEntity.fetchRequest()
        var entitiesArray: [ComicEntity] = []
        var modelsArray: [ComicModel] = []
        var predicate: NSPredicate? = nil
        
        if let term = term {
            predicate = NSPredicate(format: "name CONTAINS[cd] %@", term)
        }
        
        if limit != 0 {
            request.fetchLimit = limit
        }
        
        do {
            request.predicate = predicate
            request.fetchOffset = offset
            entitiesArray = try context.fetch(request)
            
            for entity in entitiesArray {
                if let model = ComicParser.from(coreData: entity) {
                    modelsArray.append(model)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return modelsArray
    }
    
    func find(id: Int) -> ComicModel? {
        var model: Model? = nil
        let request: NSFetchRequest<ComicEntity> = ComicEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", id)
        var entitiesArray: [ComicEntity] = []
        request.predicate = predicate
        
        do {
            entitiesArray = try context.fetch(request)
            
            if entitiesArray.count > 0 {
                model = ComicParser.from(coreData: entitiesArray[0])
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
}
