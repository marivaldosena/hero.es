//
//  HeroesListViewModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 31/12/20.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - ComicsListDelegate
protocol ComicsListDelegate: class {
    func getItemsListDidLoad(_ items: [ComicModel], _ error: Error?)
}

// MARK: - ComicsListViewModel
class ComicsListViewModel {
    private let service: ComicService
    var modelsArray: [ComicModel] = []
    weak var delegate: ComicsListDelegate?
    
    init() {
        self.service = ComicService.shared
    }
    
    init(with service: ComicService) {
        self.service = service
    }
    
    func loadItems() {
        service.loadItems { (models, error) in
            if let models = models {
                self.modelsArray = models
                self.delegate?.getItemsListDidLoad(models, nil)
            } else {
                self.delegate?.getItemsListDidLoad([], nil)
            }
        }
    }
    
    func getItems(term: String? = nil,
                  limit: Int = 0,
                  offset: Int = 0,
                  in persistentMethod: PersistentMethodEnum = .coreData) -> [ComicModel] {
        if let term = term {
            modelsArray = service.find(term: term, limit: limit, offset: offset, in: persistentMethod)
        } else {
            modelsArray = service.getItems(limit: limit, offset: offset, in: persistentMethod)
        }
        
        return modelsArray
    }
    
    func getImageUrlString(for item: ComicModel?) -> String {
        return item?.thumbnailString ?? "ComicImage"
    }
    
    func getImageUrl(for item: ComicModel?) -> URL? {
        return item?.getImageUrl()
    }
    
    func getItem(at index: Int) -> ComicModel? {
        var model: ComicModel? = nil
        
        if self.isIndexAvailable(index: index) {
            model = modelsArray[index]
        }
        
        return model
    }
    
    func getNumberOfItems() -> Int {
        return self.modelsArray.count
    }
    
    // MARK: - Private Methods
    private func isIndexAvailable(index: Int) -> Bool {
        if index > 0 && index < modelsArray.count {
            return true
        }
        
        return false
    }
}