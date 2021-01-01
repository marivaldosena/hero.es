//
//  ComicsListTableViewCell.swift
//  hero_es
//
//  Created by Marivaldo Sena on 01/01/21.
//

import UIKit
import Kingfisher

protocol ImageHolderProtocol: class {
    func getImage(for: CellItemProtocol?) -> UIImage?
}

// MARK: - ItemCell: UITableViewCell
class ItemCell: UITableViewCell {
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    private var item: CellItemProtocol?
    weak var imageHolder: ImageHolderProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func shareItem(_ sender: UIButton) {
        print("Sharing item")
    }
    
    @IBAction func likeItem(_ sender: UIButton) {
        print("Liking item")
    }

    func configure(with item: CellItemProtocol?) {
        self.item = item
        self.updateUIInterface()
    }
    
    private func updateUIInterface() {
        itemName.text = item?.name ?? "Item Name"
        itemDescription.text = item?.description ?? "Item Description"
        itemImageView.image = imageHolder?.getImage(for: item)
    }
}
