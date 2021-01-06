//
//  FavoritesViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 02/11/20.
//

import UIKit

class FavoritesViewController: UIViewController {
    let service = FavoriteService.shared
    var modelsArray: [FavoriteModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("===========================================")
        modelsArray = service.getItems()
        print(modelsArray)
        print("service.getItems()")
        print("===========================================")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("===========================================")
        let hero = FavoriteModel(id: 1, itemType: .hero, name: "Hero", resourceURI: "resourceURI", thumbnailString: "thumbnailString", description: "description")
        service.save(hero)
        print("Saving favorite hero")
        print("===========================================")
        
        let comic = FavoriteModel(id: 1, itemType: .comic, name: "Comic", resourceURI: "resourceURI", thumbnailString: "thumbnailString", description: "description")
        service.save(comic)
        print("Saving favorite comic")
        print("===========================================")
        
        modelsArray = service.find(term: "er", itemType: .hero)
        print(modelsArray)
        print("service.find(term: er)")
        print("===========================================")
        
        let foundModel = service.find(id: 1)
        print(foundModel)
        print("service.find(id: 1)")
        print("===========================================")
    }
}
