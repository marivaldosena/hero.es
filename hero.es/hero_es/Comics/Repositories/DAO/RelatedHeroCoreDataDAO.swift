//
//  RelatedHeroCoreDataDAO.swift
//  hero_es
//
//  Created by Marivaldo Sena on 03/01/21.
//

import Foundation
import CoreData

struct RelatedHeroCoreDataDAO: CoreDataDAOProtocol {
    typealias Model = RelatedHeroModel
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.context = container.viewContext
    }
    
    func save(_ model: RelatedHeroModel) {
        if find(id: model.id) != nil {
            return
        }
        
        do {
            let entity = RelatedHeroEntity(context: context)
            
            entity.id = Int64(model.id)
            entity.comicId = Int64(model.comicId)
            entity.name = model.name
            entity.resourceURI = model.resourceURI
            
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func find(term: String? = nil, limit: Int = 0, offset: Int = 0) -> [RelatedHeroModel] {
        let request: NSFetchRequest<RelatedHeroEntity> = RelatedHeroEntity.fetchRequest()
        var entitiesArray: [RelatedHeroEntity] = []
        var modelsArray: [RelatedHeroModel] = []
        
        if let term = term {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", term)
        }
        
        if limit != 0 {
            request.fetchLimit = limit
        }
        
        do {
            entitiesArray = try context.fetch(request)
            
            for entity in entitiesArray {
                if let model = RelatedHeroParser.from(coreData: entity) {
                    modelsArray.append(model)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return modelsArray
    }
    
    func find(id: Int) -> RelatedHeroModel? {
        var model: RelatedHeroModel? = nil
        
        do {
            let request: NSFetchRequest<RelatedHeroEntity> = RelatedHeroEntity.fetchRequest()
            let predicate = NSPredicate(format: "id == %i", id)
            var entitiesArray: [RelatedHeroEntity] = []
            request.predicate = predicate
            request.fetchLimit = 1
            entitiesArray = try context.fetch(request)
            
            if entitiesArray.count > 0 {
                model = RelatedHeroParser.from(coreData: entitiesArray[0])
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
}
