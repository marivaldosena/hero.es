//
//  ComicService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 01/01/21.
//

import Foundation
import Alamofire

typealias ComicServiceFinishHandlerType = (_ comics: [ComicModel]?, _ error: Error?) -> Void

enum MarvelAPIError: Error {
    case invalidData
}

// MARK: - ServiceProtocol
protocol ServiceProtocol {
    associatedtype Model = CellItemProtocol
    associatedtype RelatedModel = ItemProtocol
    
    func loadItems(limit: Int, offset: Int, completion: @escaping (_ items: [Model]?, _ error: Error?) -> Void)
    func getItems(limit: Int, offset: Int, in persistentMethod: PersistentMethodEnum) -> [Model]
    func find(limit: Int, offset: Int, in persistentMethod: PersistentMethodEnum) -> [Model]
    func find(term: String, limit: Int, offset: Int, in persistentMethod: PersistentMethodEnum) -> [Model]
    func save(_ model: Model, in persistentMethod: PersistentMethodEnum)
    func save(_ array: [Model], in persistentMethod: PersistentMethodEnum)
    func save(_ relatedModel: RelatedModel, to model: Model, in persistentMethod: PersistentMethodEnum)
    func save(_ relatedModels: [RelatedModel], to model: Model, in persistentMethod: PersistentMethodEnum)
}

// MARK: - ComicServiceProtocol: ServiceProtocol
protocol ComicServiceProtocol: ServiceProtocol where Model == ComicModel, RelatedModel == RelatedHeroModel {
}

// MARK: - ComicService: ComicServiceProtocol
class ComicService: ComicServiceProtocol {
    typealias Model = ComicModel
    typealias RelatedModel = RelatedHeroModel
    
    static var shared = ComicService()
    static var apiManager: MarvelAPIManagerProtocol = MarvelAPIManager.shared
    private var repository = ComicRepository.shared
    
    
    private func requestComics(limit: Int = 0, offset: Int = 0, completion: @escaping ComicServiceFinishHandlerType) {
        var params = [String:Any]()
        
        if limit != 0 {
            params["limit"] = limit
        }
        
        if offset != 0 {
            params["offset"] = offset
        }
        
        let urlString: String = ComicService.apiManager.buildUrl(url: "/v1/public/comics", params: params)
        
        AF.request(urlString).responseJSON { (response) in
            if let json = response.data {
                let modelsArray = ComicParser.from(json: json)
                completion(modelsArray, nil)
            } else {
                completion([], MarvelAPIError.invalidData)
            }
        }
    }
    
    func loadItems(limit: Int = 0, offset: Int = 0, completion: @escaping ComicServiceFinishHandlerType) {
        let modelsArray = repository.find()
        
        self.requestComics(limit: limit, offset: offset) { (comics, error) in
            if let comics = comics {
                self.save(comics)
                completion(comics, error)
            } else {
                completion(modelsArray, error)
            }
        }
    }
    
    func getItems(limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        var modelsArray: [ComicModel] = []
        
        if persistentMethod != .online {
            modelsArray = repository.find(limit: limit, offset: offset, in: persistentMethod)
        } else {
            DispatchQueue.global(qos: .background).sync {
                self.loadItems(limit: limit, offset: offset) { (comics, error) in
                    modelsArray = comics ?? []
                }
            }
        }
        
        return modelsArray
    }
    
    func find(limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        // TODO: Implement search online
        return repository.find(limit: limit, offset: offset, in: persistentMethod)
    }
    
    func find(term: String, limit: Int = 0, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        // TODO: Implement search online
        return repository.find(term: term, limit: limit, offset: offset, in: persistentMethod)
    }
    
    func find(id: Int, in persistentMethod: PersistentMethodEnum = .coreData) -> ComicModel? {
        if persistentMethod != .online {
            return repository.find(id: id)
        }
        return nil
    }
    
    func save(_ model: ComicModel, in persistentMethod: PersistentMethodEnum) {
        if persistentMethod != .online {
            repository.save(model, in: persistentMethod)
        }
        // TODO: Implement save online
    }
    
    func save(_ array: [ComicModel], in persistentMethod: PersistentMethodEnum = .coreData) {
        for item in array {
            save(item, in: persistentMethod)
        }
    }
    
    func save(_ relatedModel: RelatedHeroModel, to model: ComicModel, in persistentMethod: PersistentMethodEnum) {
        if persistentMethod != .online {
            repository.save([relatedModel], to: model, in: persistentMethod)
        }
        // TODO: Implement save online
    }
    
    func save(_ relatedModels: [RelatedHeroModel],
                              to model: ComicModel,
                              in persistentMethod: PersistentMethodEnum) {
        for item in relatedModels {
            save(item, to: model, in: persistentMethod)
        }
    }
}
