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

struct HeroRepository {
    static var shared = HeroRepository()
    private var heroDAO = HeroCoreDataDAO(container: DBManager.shared.getContainer())
    
    private init() {}
    
    mutating func save(hero: HeroModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        switch persistentMethod {
        case .coreData: self.saveHeroInCoreData(hero)
        case .realm: break
        case .firebase: break
        default: break
        }
    }
    
    func find(term: String? = nil, limit: Int = 20, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
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
    
    func find(term: String, limit: Int = 20, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
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
    
    private mutating func saveHeroInCoreData(_ hero: HeroModel) {
        self.heroDAO.save(hero: hero)
    }
    
    private func findHeroesInCoreData(term: String? = nil) -> [HeroModel] {
        if let term = term {
            return heroDAO.find(term: term)
        }
        return heroDAO.find()
    }
    
//    private func saveAllRelatedComics(hero: HeroModel, json: JSON) {
//        let numberOfComics = json["available"].intValue
//        let jsonArray = json["items"].arrayValue
//
//        for item in jsonArray {
//            let name = item["name"].stringValue
//            let resourceURI = item["resourceURI"].stringValue
//            let id = getComicId(resourceURI: resourceURI)
//
//            let comic = RelatedComicModel(id: id, name: name, resourceURI: resourceURI)
//        }
//    }
}
