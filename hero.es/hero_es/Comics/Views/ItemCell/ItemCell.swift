//
//  ComicsListTableViewCell.swift
//  hero_es
//
//  Created by Marivaldo Sena on 01/01/21.
//

import UIKit
import Kingfisher

// MARK: - ShareItemProtocol
protocol ShareAndLikeItemProtocol: class {
    func share(item: CellItemProtocol?)
    func like(item: CellItemProtocol?)
}

// MARK: - ItemCell: UITableViewCell
class ItemCell: UITableViewCell {
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    weak var delegate: ShareAndLikeItemProtocol?
    private var item: CellItemProtocol?
    private var itemType: SearchItemType? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func shareItem(_ sender: UIButton) {
        delegate?.share(item: item)
    }
    
    @IBAction func likeItem(_ sender: UIButton) {
        delegate?.like(item: item)
    }

    func configure(with item: CellItemProtocol?, itemType: SearchItemType? = nil) {
        self.item = item
        self.itemType = itemType
        self.updateUIInterface()
    }
    
    private func updateUIInterface() {
        DispatchQueue.main.async {
            self.itemName.text = self.item?.name ?? "Item Name"
            self.itemDescription.text = self.item?.description ?? "Item Description"
            self.itemImageView.image = self.item?.getImage()
            self.likeButton.setImage(self.getLikeButtonImage(), for: .normal)
        }
    }
    
    private func getLikeButtonImage() -> UIImage? {
        if let item = item  {
            if item.isFavorite() == true {
                return UIImage(systemName: "heart.fill")
            }
        }
        return UIImage(systemName: "heart")
    }
}
