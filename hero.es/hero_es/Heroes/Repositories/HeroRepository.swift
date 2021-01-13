//
//  HeroRepository.swift
//  hero_es
//
//  Created by Marivaldo Sena on 17/12/20.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype Model
}

// MARK: - HeroRepository
struct HeroRepository {
    static var shared = HeroRepository()
    private var heroDAO: HeroCoreDataDAO
    private var relatedComicDAO: RelatedComicCoreDataDAO
    private var comicHeroRelationshipDAO: ComicHeroRelationshipCoreDataDAO
    
    private init() {
        let container = DBManager.shared.getContainer()
        heroDAO = HeroCoreDataDAO(container: container)
        relatedComicDAO = RelatedComicCoreDataDAO(container: container)
        comicHeroRelationshipDAO = ComicHeroRelationshipCoreDataDAO(container: container)
    }
    
    // MARK: - Public Methods
    mutating func save(hero: HeroModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        switch persistentMethod {
        case .coreData: self.saveHeroInCoreData(hero)
        case .realm: break
        case .firebase: break
        default: break
        }
    }
    
    func find(term: String? = nil,
              limit: Int = 20,
              offset: Int = 0,
              in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
        var modelsArray: [HeroModel] = []
        switch persistentMethod {
        case .coreData:
            modelsArray = findHeroesInCoreData()
        case .realm: break
        case .firebase: break
        default: break
        }
        return modelsArray
    }
    
    func find(term: String,
              limit: Int = 20,
              offset: Int = 0,
              in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
        var modelsArray: [HeroModel] = []
        switch persistentMethod {
        case .coreData:
            modelsArray = findHeroesInCoreData(term: term)
        case .realm: break
        case .firebase: break
        default: break
        }
        return modelsArray
    }
    
    func find(id: Int, in persistentMethod: PersistentMethodEnum = .coreData) -> HeroModel? {
        switch persistentMethod {
        case .coreData:
            return findHeroInCoreData(id: id)
        default:
            return nil
        }
    }
    
    func save(comic: RelatedComicModel,
              to hero: HeroModel,
              in persistentMethod: PersistentMethodEnum = .coreData) {
        switch persistentMethod {
        case .coreData: saveRelatedComicToHeroInCoreData(comic, to: hero)
        default: break
        }
    }
    
    // MARK: - Private Methods
    private mutating func saveHeroInCoreData(_ hero: HeroModel) {
        self.heroDAO.save(hero)
    }
    
    private func findHeroesInCoreData(term: String? = nil) -> [HeroModel] {
        if let term = term {
            return heroDAO.find(term: term)
        }
        return heroDAO.find()
    }
    
    private func findHeroInCoreData(id: Int) -> HeroModel? {
        return heroDAO.find(id: id)
    }
    
    private func saveRelatedComicToHeroInCoreData(_ comic: RelatedComicModel, to hero: HeroModel) {
        relatedComicDAO.save(comic)
        let comicHeroModel = ComicHeroModel(heroId: hero.id, comicId: comic.id)
        comicHeroRelationshipDAO.save(comicHeroModel)
    }
}
