//
//  RelatedComicCoreDataDAO.swift
//  hero_es
//
//  Created by Marivaldo Sena on 25/12/20.
//

import Foundation
import CoreData

// MARK: - RelatedComicCoreDataDAO: CoreDataDAOProtocol
struct RelatedComicCoreDataDAO: CoreDataDAOProtocol {
    typealias Model = RelatedComicModel
    
    private var persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.context = container.viewContext
    }
    
    func save(_ model: Model) {
        do {
            if find(id: model.id) != nil {
                return
            }
            
            let entity = RelatedComicEntity(context: context)
            entity.id = Int64(model.id)
            entity.name = model.name
            entity.resourceURI = model.resourceURI
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func find(term: String?, limit: Int = 0, offset: Int = 0) -> [Model] {
        var modelsArray: [Model] = []
        var entitiesArray: [RelatedComicEntity] = []
        let request: NSFetchRequest<RelatedComicEntity> = RelatedComicEntity.fetchRequest()
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
            
            entitiesArray.forEach { (entity) in
                if let model = RelatedComicParser.from(coreData: entity) {
                    modelsArray.append(model)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return modelsArray
    }
    
    func find(id: Int) -> Model? {
        var model: Model? = nil
        let request: NSFetchRequest<RelatedComicEntity> = RelatedComicEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", id)
        var entitiesArray = [RelatedComicEntity]()
        
        do {
            request.predicate = predicate
            entitiesArray = try self.context.fetch(request)
            
            if entitiesArray.count > 0 {
                model = RelatedComicParser.from(coreData: entitiesArray[0])
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
}
