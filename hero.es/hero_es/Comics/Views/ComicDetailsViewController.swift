//
//  ComicDetailsViewController.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import UIKit

class ComicDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemType: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var item: CellItemProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUIInterface()
    }
    
    static func getController(_ item: CellItemProtocol) -> ComicDetailsViewController? {
        guard let viewController = UIStoryboard(name: "ComicDetails", bundle: nil).instantiateInitialViewController() as? ComicDetailsViewController else { return nil }
        viewController.item = item
        return viewController
    }
    
    static func getController(_ item: ComicModel) -> ComicDetailsViewController? {
        guard let item = item as? CellItemProtocol else { return nil }
        return getController(item)
    }
    
    func updateUIInterface() {
        title = item?.name ?? "Details"
        guard let item = item else { return }
        DispatchQueue.main.async {
            self.imageView.image = item.getImage()
            self.itemName.text = item.name
            self.itemType.text = "Marvel"
            self.itemDescription.text = item.description
        }
    }
}
