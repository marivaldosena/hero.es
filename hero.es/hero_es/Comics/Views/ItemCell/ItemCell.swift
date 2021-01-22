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
    @IBOutlet weak var containerView: UIView!
    
    weak var delegate: ShareAndLikeItemProtocol?
    private var item: CellItemProtocol?
    private var itemType: SearchItemType? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = StyleGuide.Color.secondaryWhite
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
            
            self.setupImageView()
            self.setupContainerView()
        }
    }
    
    private func setupImageView() {
        itemImageView.roundCorners(cornerRadius: 15, corners: .allCorners)
        itemImageView.layer.borderWidth = 2
        itemImageView.layer.borderColor = StyleGuide.Color.darkBlue.cgColor
    }
    
    private func setupContainerView() {
        containerView.roundCorners(cornerRadius: 15, corners: .allCorners)
        containerView.backgroundColor = StyleGuide.Color.white
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = StyleGuide.Color.gray.cgColor
    }
    
    private func getLikeButtonImage() -> UIImage? {
        if let item = item  {
            if item.isFavorite() == true {
                return UIImage(named: "like")
            }
        }
        return UIImage(named: "like2")
    }
}
