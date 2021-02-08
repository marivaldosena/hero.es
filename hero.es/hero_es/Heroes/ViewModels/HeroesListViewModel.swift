//
//  HeroViewModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 20/12/20.
//

import Foundation

protocol HeroListDelegate: class {
    func getItemsListDidFinish(_ heroes: [HeroModel], _ error: Error?)
}

class HeroesListViewModel {
    private var modelsArray: [HeroModel] = []
    private var term: String? = nil
    private var activeHero: HeroModel?
    private var service = HeroService.shared
    weak var delegate: HeroListDelegate?
    
    init() {
        if self.modelsArray.count > 0 {
            self.activeHero = self.modelsArray[0]
        }
    }
    
    func loadAllHeroes(limit: Int = 20, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData,
                      completion: @escaping (_ heroes: [HeroModel], _ error: Error?) -> Void) {
        self.service.getAllHeroes(limit: limit, offset: offset, completion: { (heroes, error) in
            if let heroes = heroes {
                self.modelsArray = heroes
                self.modelsArray.shuffle()
                completion(heroes, nil)
            } else {
                self.modelsArray = []
                completion([], error)
            }
        })
    }
    
    func loadAllHeroes(limit: Int = 20, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) {
        loadAllHeroes(limit: limit, offset: offset) { (heroes, error) in
            self.modelsArray = heroes
            self.modelsArray.shuffle()
            self.delegate?.getItemsListDidFinish(heroes, error)
        }
    }
    
    func getAllHeroes(limit: Int = 20, offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
        DispatchQueue.global(qos: .background).sync {
            loadAllHeroes(limit: limit, offset: offset) { (heroes, _) in
                self.modelsArray = heroes
                self.modelsArray.shuffle()
            }
        }
        
        return modelsArray
    }
    
    func search(term: String = "", limit: Int = 20,
                offset: Int = 0, in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
        if !term.isEmpty {
            modelsArray = self.service.find(term: term, limit: limit, offset: offset, in: persistentMethod)
            self.modelsArray.shuffle()
        } else {
            modelsArray = self.service.find(limit: limit, offset: offset, in: persistentMethod)
            self.modelsArray.shuffle()
        }
        return modelsArray
    }
    
    func setActiveHero(_ item: HeroModel?) {
        self.activeHero = item
    }
    
    func getActiveHero() -> HeroModel? {
        return self.activeHero
    }
    
    func getItem(at index: Int) -> HeroModel {
        return modelsArray[index]
    }
    
    func getNumberOfItems() -> Int {
        return modelsArray.count
    }

    func getTitleView() -> String {
        return "Heroes"
    }
}
