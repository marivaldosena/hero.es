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
    
    func requestHeroes(limit: Int = 0, offset: Int = 0, completion: @escaping HeroServiceFinishHandlerType) {
        var params = [String:Any]()
        
        if limit != 0 {
            params["limit"] = limit
        }
        
        if offset != 0 {
            params["offset"] = offset
        }
        
        let urlString: String = ComicService.apiManager.buildUrl(url: "/v1/public/characters", params: params)
        
        AF.request(urlString).responseJSON { (response) in
            if let json = response.data {
                let heroes = HeroParser.from(json: json)
                completion(heroes, nil)
            } else {
                completion([], MarvelAPIError.invalidData)
            }
        }
    }
    
    func getAllHeroes(limit: Int = 0,
                      offset: Int = 0,
                      in persistentMethod: PersistentMethodEnum = .coreData,
                      completion: @escaping HeroServiceFinishHandlerType) {
        var modelsArray: [HeroModel] = []
        
        self.requestHeroes(limit: limit, offset: offset) { (heroes, error) in
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
    
    func save(model: HeroModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        repository.save(hero: model, in: persistentMethod)
        
        if model.relatedComics.count > 0 {
            saveAllRelatedComics(model.relatedComics, to: model, in: persistentMethod)
        }
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
    
    func find(id: Int, in persistentMethod: PersistentMethodEnum = .coreData) -> HeroModel? {
        return repository.find(id: id)
    }
    
    func save(comic: RelatedComicModel,
              to hero: HeroModel,
              in persistentMethod: PersistentMethodEnum = .coreData) {
        repository.save(comic: comic, to: hero, in: persistentMethod)
    }
    
    func saveAllRelatedComics(_ comics: [RelatedComicModel],
              to hero: HeroModel,
              in persistentMethod: PersistentMethodEnum = .coreData) {
        for comic in comics {
            save(comic: comic, to: hero, in: persistentMethod)
        }
    }
}
