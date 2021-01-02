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
    
    private var item: CellItemProtocol?
    weak var delegate: ShareAndLikeItemProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func shareItem(_ sender: UIButton) {
        delegate?.share(item: item)
    }
    
    @IBAction func likeItem(_ sender: UIButton) {
        delegate?.like(item: item)
    }

    func configure(with item: CellItemProtocol?) {
        self.item = item
        self.updateUIInterface()
    }
    
    private func updateUIInterface() {
        itemName.text = item?.name ?? "Item Name"
        itemDescription.text = item?.description ?? "Item Description"
        itemImageView.image = item?.getImage()
    }
}
