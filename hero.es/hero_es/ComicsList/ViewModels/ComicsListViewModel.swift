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
    let service = ComicService.shared
    var modelsArray: [ComicModel] = []
    weak var delegate: ComicsListDelegate?
    
    func loadAllItems() {
        service.requestComics { (models, error) in
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
        guard let url = URL(string: getImageUrlString(for: item)) else { return nil }
        return url
    }
    
    func getAllItems() -> [ComicModel] {
        return modelsArray
    }
    
    func getItem(at index: Int) -> ComicModel? {
        var model: ComicModel? = nil
        
        if self.isIndexAvailable(index: index) {
            model = modelsArray[index]
        }
        
        return model
    }
    
    private func isIndexAvailable(index: Int) -> Bool {
        if index > 0 && index < modelsArray.count {
            return true
        }
        
        return false
    }
}

// MARK: - ComicsListViewModel: ImageHolderProtocol
extension ComicsListViewModel: ImageHolderProtocol {
    func getImage(for item: CellItemProtocol?) -> UIImage?  {
        let imageView = UIImageView()
        
        if let url = getImageUrl(for: item as? ComicModel) {
            imageView.kf.setImage(with: url)
            imageView.kf.indicatorType = .activity
        } else {
            imageView.image = UIImage(named: "ComicImage")
        }
        
        return imageView.image
    }
}
