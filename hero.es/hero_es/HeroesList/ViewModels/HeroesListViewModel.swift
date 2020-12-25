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
    private var selectedModel: HeroModel?
    private var service = HeroService.shared
    weak var delegate: HeroListDelegate?
    
    func getAllHeroes(in persistentMethod: PersistentMethodEnum = .coreData,
                      completion: @escaping (_ heroes: [HeroModel], _ error: Error?) -> Void) {
        self.service.getAllHeroes(completion: { (heroes, error) in
            if let heroes = heroes {
                completion(heroes, nil)
            } else {
                completion([], error)
            }
        })
    }
    
    func getAllHeroes(in persistentMethod: PersistentMethodEnum = .coreData) {
        getAllHeroes { (heroes, error) in
            self.delegate?.getItemsListDidFinish(heroes, error)
        }
    }
}
