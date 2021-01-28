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
    
    func loadAllHeroes(in persistentMethod: PersistentMethodEnum = .coreData,
                      completion: @escaping (_ heroes: [HeroModel], _ error: Error?) -> Void) {
        self.service.getAllHeroes(completion: { (heroes, error) in
            if let heroes = heroes {
                self.modelsArray = heroes
                completion(heroes, nil)
            } else {
                self.modelsArray = []
                completion([], error)
            }
        })
    }
    
    func loadAllHeroes(in persistentMethod: PersistentMethodEnum = .coreData) {
        loadAllHeroes { (heroes, error) in
            self.modelsArray = heroes
            self.delegate?.getItemsListDidFinish(heroes, error)
        }
    }
    
    func getAllHeroes(in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
        var modelsArray: [HeroModel] = []
        
        DispatchQueue.global(qos: .background).sync {
            loadAllHeroes { (heroes, _) in
                modelsArray = heroes
            }
        }
        
        return modelsArray
    }
    
    func search(term: String = "", in persistentMethod: PersistentMethodEnum = .coreData) -> [HeroModel] {
        var modelsArray: [HeroModel] = []
        if !term.isEmpty {
            modelsArray = self.service.find(term: term, in: persistentMethod)
        } else {
            modelsArray = self.service.find()
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
}
