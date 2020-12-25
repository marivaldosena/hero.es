//
//  ServiceHeroes.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation
import Alamofire

typealias HeroServiceFinishHandlerType = (_ heroes: [HeroModel]?, _ error: Error?) -> Void

class HeroService {
    static let shared = HeroService()
    private var repository = HeroRepository.shared
    
    private init() {}
    
    func requestHeroes(completion: @escaping HeroServiceFinishHandlerType) {
        if let path = Bundle.main.path(forResource: "heroes-list", ofType: "json") {
            guard let json = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
            let heroes = HeroParser.from(json: json)
            completion(heroes, nil)
        }
    }
    
    func getAllHeroes(in persistentMethod: PersistentMethodEnum = .coreData,
                      limit: Int = 0,
                      offset: Int = 0,
                      completion: @escaping HeroServiceFinishHandlerType) {
        var modelsArray: [HeroModel] = []
        
        // TODO: Refactor this method
        if persistentMethod != .online {
            modelsArray = repository.find(in: persistentMethod)
            // TODO: 1.1.2 Verificar no Realm
            
            if modelsArray.count > 0 {
                completion(modelsArray, nil)
            } else {
                self.requestHeroes { (heroes, error) in
                    if let heroes = heroes {
                        self.saveAll(array: heroes)
                        modelsArray = self.repository.find(in: persistentMethod)
                    }
                    completion(modelsArray, error)
                }
            }
        } else {
            self.requestHeroes { (heroes, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(modelsArray, error)
                }
                
                if let heroes = heroes {
                    self.saveAll(array: heroes, in: persistentMethod)
                    modelsArray = self.repository.find(in: persistentMethod)
                    completion(modelsArray, error)
                } else {
                    completion(modelsArray, error)
                }
            }
        }
    }
    
    func save(model: HeroModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        repository.save(hero: model, in: persistentMethod)
    }
    
    func saveAll(array: [HeroModel], in persistentMethod: PersistentMethodEnum = .coreData) {
        for item in array {
            self.save(model: item, in: persistentMethod)
        }
    }
    
    func find(limit: Int = 20, offset: Int = 0,
              in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
        return repository.find(in: persistentMethod)
    }
    
    func find(term: String,
              limit: Int = 20,
              offset: Int = 0,
              in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
        return repository.find(term: term, in: persistentMethod)
    }
    
    func save(comic: RelatedComicModel,
              to hero: HeroModel,
              in persistentMethod: PersistentMethodEnum = .coreData) {
    }
}
