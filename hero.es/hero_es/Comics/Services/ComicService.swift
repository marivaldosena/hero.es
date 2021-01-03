//
//  ComicService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 01/01/21.
//

import Foundation

typealias ComicServiceFinishHandlerType = (_ comics: [ComicModel]?, _ error: Error?) -> Void

// MARK: - ServiceProtocol
protocol ServiceProtocol {
    associatedtype Model = CellItemProtocol
    associatedtype RelatedModel = ItemProtocol
    
    func loadItems(completion: @escaping (_ items: [Model]?, _ error: Error?) -> Void)
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
    private var repository = ComicRepository.shared
    
    private func requestComics(completion: @escaping ComicServiceFinishHandlerType) {
        guard let path = Bundle.main.path(forResource: "comics-list", ofType: "json") else { return }
        guard let json = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
        let modelsArray = ComicParser.from(json: json)
        completion(modelsArray, nil)
    }
    
    func loadItems(completion: @escaping ComicServiceFinishHandlerType) {
        let modelsArray = repository.find()
        
        if modelsArray.count > 0 {
            completion(modelsArray, nil)
        } else {
            self.requestComics { (comics, error) in
                if let comics = comics {
                    self.save(comics)
                    completion(comics, error)
                } else {
                    completion(modelsArray, error)
                }
            }
        }
    }
    
    func getItems(limit: Int = 0,
                  offset: Int = 0,
                  in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        var modelsArray: [ComicModel] = []
        
        if persistentMethod != .online {
            modelsArray = repository.find(limit: limit, offset: offset, in: persistentMethod)
        } else {
            DispatchQueue.global(qos: .background).sync {
                self.loadItems { (comics, error) in
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
