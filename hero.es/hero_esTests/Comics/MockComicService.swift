//
//  MockComicService.swift
//  hero_esTests
//
//  Created by Marivaldo Sena on 02/01/21.
//

import XCTest
@testable import hero_es

// MARK: - MockComicService: ComicServiceProtocol
class MockComicService: ComicService {
    private var modelsArray: [ComicModel] = [
        ComicModel(
            id: 82967,
            name: "Marvel Previews (2017)",
            resourceURI : "http://gateway.marvel.com/v1/public/comics/82967",
            description : "",
            modified : Date(timeIntervalSince1970: TimeInterval(602778932.0)),
            upc: "75960608839302811",
            pageCount : 112,
            thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg",
            relatedHeroes: []
        ),
        ComicModel(
            id : 82965,
            name : "Marvel Previews (2017)",
            resourceURI : "http://gateway.marvel.com/v1/public/comics/82965",
            description : "",
            modified: Date(timeIntervalSince1970: TimeInterval(588114687.0)),
            upc : "75960608839302611",
            pageCount : 152,
            thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg",
            relatedHeroes: []
        ),
        ComicModel(
            id : 82970,
            name : "Marvel Previews (2017)",
            resourceURI : "http://gateway.marvel.com/v1/public/comics/82970",
            description : "",
            modified: Date(timeIntervalSince1970: TimeInterval(602778932.0)),
            upc : "75960608839303111",
            pageCount : 112,
            thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/c/80/5e3d7536c8ada.jpg",
            relatedHeroes :[]
        ),
        ComicModel(
            id : 1220,
            name : "Amazing Spider-Man 500 Covers Slipcase - Book II (Trade Paperback)",
            resourceURI : "http://gateway.marvel.com/v1/public/comics/1220",
            description : "",
            modified : nil,
            upc : "",
            pageCount : 0,
            thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg",
            relatedHeroes : []
        ),
        ComicModel(
            id : 1003,
            name : "Sentry, the (Trade Paperback)",
            resourceURI : "http://gateway.marvel.com/v1/public/comics/1003",
            description : "On the edge of alcoholism and a failed marriage, Bob Reynolds wakes up to discover his true nature. A forgotten hero, he must unravel the conspiracy to erase his memory from mankind before an evil entity returns.",
            modified : nil,
            upc : "",
            pageCount : 240,
            thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/f/c0/4bc66d78f1bee.jpg",
            relatedHeroes : []
        )
    ]
    
    override func loadItems(completion: @escaping ([ComicModel]?, Error?) -> Void) {
        completion(modelsArray, nil)
    }
    
    override func getItems(limit: Int = 5, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        return modelsArray
    }
    
    override func find(limit: Int = 5, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        return modelsArray
    }
    
    override func find(term: String, limit: Int = 5, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        let foundItems = modelsArray.filter { (model) -> Bool in
            return model.searchBy(term: term)
        }
        return foundItems
    }
    
    override func save(_ model: ComicModel, in persistentMethod: PersistentMethodEnum = .coreData) {
        modelsArray.append(model)
    }
    
    override func save(_ array: [ComicModel], in persistentMethod: PersistentMethodEnum = .coreData) {
        modelsArray.append(contentsOf: array)
    }
    
    override func save(_ relatedModel: RelatedHeroModel,
              to model: ComicModel,
              in persistentMethod: PersistentMethodEnum = .coreData) {
        let index = modelsArray.firstIndex { (comic) -> Bool in
            return comic.id == model.id
        }
        
        if let index = index {
            var comic = modelsArray[index]
            comic.relatedHeroes.append(relatedModel)
            modelsArray[index] = comic
        }
    }
    
    func loadAllItems(completion: @escaping ComicServiceFinishHandlerType) {
        completion(modelsArray, nil)
    }
}
