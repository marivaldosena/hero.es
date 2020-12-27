//
//  ComicHeroRelationshipCoreDataDAO.swift
//  hero_es
//
//  Created by Marivaldo Sena on 26/12/20.
//

import Foundation
import CoreData

// MARK: - ComicHeroRelationshipCoreDataDAO: CoreDataDAOProtocol
struct ComicHeroRelationshipCoreDataDAO: CoreDataDAOProtocol {
    typealias Model = ComicHeroModel
    
    private var persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.context = persistentContainer.viewContext
    }
    
    func save(_ model: Model) {
        do {
            if find(comicId: model.comicId, heroId: model.heroId) != nil {
                return
            }
            
            let entity = ComicHeroEntity(context: self.context)
            entity.heroId = Int64(model.heroId)
            entity.comicId = Int64(model.comicId)
            // TODO: Is it necessary to add related entities to this one? Such as, hero and comic?
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func find(term: String?, limit: Int = 0, offset: Int = 0) -> [Model] {
        var modelsArray: [Model] = []
        var entitiesArray: [ComicHeroEntity] = []
        let request: NSFetchRequest<ComicHeroEntity> = ComicHeroEntity.fetchRequest()
        
        let heroesArray = HeroCoreDataDAO(container: persistentContainer).find(term: term)
        let comicsArray = RelatedComicCoreDataDAO(container: persistentContainer).find(term: term)
        
        var ids: [Int] = heroesArray.map { (hero) -> Int in
            return hero.id
        }
        
        ids.append(contentsOf: comicsArray.map({ (comic) -> Int in
            return comic.id
        }))
        
        if limit != 0 {
            request.fetchLimit = limit
        }
        
        let predicate = NSPredicate(format: "(heroId IN %@) OR (comicId IN %@)", ids, ids)
        
        do {
            request.predicate = predicate
            request.fetchOffset = 0
            entitiesArray = try context.fetch(request)
            
            for entity in entitiesArray {
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
        return find(comicId: id, heroId: id)
    }
    
    func find(comicId: Int, heroId: Int) -> Model? {
        var model: Model? = nil
        let request: NSFetchRequest<ComicHeroEntity> = ComicHeroEntity.fetchRequest()
        let predicate = NSPredicate(format: "comicId == %i AND heroId == %i", comicId, heroId)
        var entitiesArray: [ComicHeroEntity] = []
        
        do {
            request.predicate = predicate
            entitiesArray = try context.fetch(request)
            
            if entitiesArray.count > 0 {
                model = RelatedComicParser.from(coreData: entitiesArray[0])
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return model
    }
}
