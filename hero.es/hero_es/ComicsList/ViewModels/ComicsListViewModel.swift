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
    var service: ComicServiceProtocol = ComicService.shared
    var modelsArray: [ComicModel] = []
    weak var delegate: ComicsListDelegate?
    
    func loadAllItems() {
        service.loadAllItems { (models, error) in
            if let models = models {
                self.modelsArray = models
                self.delegate?.getItemsListDidLoad(models, nil)
            } else {
                self.delegate?.getItemsListDidLoad([], nil)
            }
        }
    }
    
    func getImageUrlString(for item: ComicModel?) -> String {
        return item?.thumbnailString ?? "ComicImage"
    }
    
    func getImageUrl(for item: ComicModel?) -> URL? {
        return item?.getImageUrl()
    }
    
    func getAllItems() -> [ComicModel] {
        DispatchQueue.global(qos: .background).sync {
            self.loadAllItems()
        }
        
        return self.modelsArray
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
