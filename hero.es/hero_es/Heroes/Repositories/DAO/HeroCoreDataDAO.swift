//
//  HeroCoreDataDao.swift
//  hero_es
//
//  Created by Marivaldo Sena on 17/12/20.
//

import UIKit
import CoreData

// MARK: - HeroCoreDataDAO: CoreDataDAOProtocol
struct HeroCoreDataDAO: CoreDataDAOProtocol {
    typealias Model = HeroModel
    private var persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.context = persistentContainer.viewContext
    }
    
    func save(_ model: Model) {
        do {
            if find(id: model.id) != nil {
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZZZZZ"
            
            let entity = HeroEntity(context: self.context)
            entity.id = Int64(model.id)
            entity.name = model.name
            entity.descriptionText = model.description
            entity.thumbnail = model.thumbnailString
            entity.resourceURI = model.resourceURI
            entity.modified = dateFormatter.date(from: model.modified) ?? Date()
            entity.numberOfComics = Int64(model.numberOfComics)
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func find(term: String? = nil, limit: Int = 0, offset: Int = 0) -> [Model] {
        let request: NSFetchRequest<HeroEntity> = HeroEntity.fetchRequest()
        var entitiesArray: [HeroEntity] = []
        var modelsArray: [Model] = []
        var predicate: NSPredicate? = nil
        
        if let term = term {
            predicate = NSPredicate(format: "name CONTAINS[cd] %@", term)
        }
        
        do {
            request.predicate = predicate
            if limit != 0 {
                request.fetchLimit = limit
            }
            request.fetchOffset = offset
            
            entitiesArray = try self.context.fetch(request)
            
            entitiesArray.forEach { entity in
                guard let model = HeroParser.from(coreData: entity) else { return }
                modelsArray.append(model)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return modelsArray
    }
    
    func find(id: Int) -> Model? {
        var model: Model? = nil
        let request: NSFetchRequest<HeroEntity> = HeroEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", id)
        var entitiesArray: [HeroEntity] = []
        
        do {
            request.predicate = predicate
            entitiesArray = try self.context.fetch(request)
            
            if entitiesArray.count > 0 {
                model = HeroParser.from(coreData: entitiesArray[0])
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
}
