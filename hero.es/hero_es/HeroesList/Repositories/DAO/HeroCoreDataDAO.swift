//
//  HeroCoreDataDao.swift
//  hero_es
//
//  Created by Marivaldo Sena on 17/12/20.
//

import UIKit
import CoreData

struct HeroCoreDataDAO {
    private var persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.context = persistentContainer.viewContext
    }
    
    mutating func save(hero: HeroModel) {
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZZZZZ"
            
            let heroEntity = HeroEntity(context: self.context)
            heroEntity.id = Int64(hero.id)
            heroEntity.name = hero.name
            heroEntity.descriptionText = hero.description
            heroEntity.thumbnail = hero.thumbnail.url
            heroEntity.resourceURI = hero.resourceURI
            heroEntity.modified = dateFormatter.date(from: hero.modified) ?? Date()
            heroEntity.numberOfComics = Int64(hero.numberOfComics)
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func find(term: String? = nil, limit: Int = 0, offset: Int = 0) -> [HeroModel] {
        let request: NSFetchRequest<HeroEntity> = HeroEntity.fetchRequest()
        var entitiesArray: [HeroEntity] = []
        var modelsArray: [HeroModel] = []
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
}
