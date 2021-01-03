//
//  ComicRepository.swift
//  hero_es
//
//  Created by Marivaldo Sena on 02/01/21.
//

import Foundation

// MARK: - ComicRepository
struct ComicRepository {
    // MARK: - Private Properties
    static var shared: ComicRepository = ComicRepository()
    private var comicDAO: ComicCoreDataDAO
    private var relatedHeroDAO: RelatedHeroCoreDataDAO
    
    private init() {
        let container = DBManager.shared.getContainer()
        comicDAO = ComicCoreDataDAO(container: container)
        relatedHeroDAO = RelatedHeroCoreDataDAO(container: container)
    }
    
    // MARK: - Public Methods
    func find(limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        switch persistentMethod {
        case .coreData:
            return findModelsInCoreData(term: nil, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func find(term: String, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        switch persistentMethod {
        case .coreData:
            return findModelsInCoreData(term: term, limit: limit, offset: offset)
        default: return []
        }
    }
    
    func save(_ model: ComicModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        switch persistentMethod {
        case .coreData:
            saveModelInCoreData(model)
            save(model.relatedHeroes, to: model, in: persistentMethod)
        default: break
        }
    }
    
    func save(_ array: [ComicModel], in persistentMethod: PersistentMethodEnum = .coreData) {
        for model in array {
            save(model, in: persistentMethod)
        }
    }
    
    func save(_ relatedModel: RelatedHeroModel, to model: ComicModel, in persistentMethod: PersistentMethodEnum) {
        switch persistentMethod {
        case .coreData:
            saveRelatedModelInCoreData(relatedModel, to: model)
        default: break
        }
    }
    
    func save(_ relatedModels: [RelatedHeroModel], to model: ComicModel, in persistentMethod: PersistentMethodEnum) {
        for item in relatedModels {
            save(item, to: model, in: persistentMethod)
        }
    }
    
    // MARK: - Private Methods
    private func saveModelInCoreData(_ model: ComicModel) {
        comicDAO.save(model)
    }
    
    private func findModelsInCoreData(term: String? = nil, limit: Int = 0, offset: Int = 0) -> [ComicModel] {
        if let term = term, !term.isEmpty {
            return comicDAO.find(term: term, limit: limit, offset: offset)
        }
        return comicDAO.find()
    }
    
    private func saveRelatedModelInCoreData(_ relatedModel: RelatedHeroModel, to model: ComicModel) {
        relatedHeroDAO.save(relatedModel)
    }
}
