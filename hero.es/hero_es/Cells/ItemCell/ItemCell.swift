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
        
        backgroundColor = StyleGuide.View.background
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
            self.shareButton.setImage(self.getShareButtonImage(), for: .normal)
            self.setupImageView()
            self.setupContainerView()
            self.setupLabels()
        }
    }
    
    private func setupImageView() {
        itemImageView.roundCorners(cornerRadius: 15, corners: .allCorners)
        itemImageView.layer.borderWidth = 2
        itemImageView.layer.borderColor = StyleGuide.ItemCell.borderColor.cgColor
    }
    
    private func setupContainerView() {
        containerView.roundCorners(cornerRadius: 15, corners: .allCorners)
        containerView.backgroundColor = StyleGuide.ContainerViewCell.background
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = StyleGuide.ItemCell.borderColor.cgColor
        
        // Shadow
//        containerView.layer.shadowColor = StyleGuide.Color.darkGray.cgColor
//        containerView.layer.shadowOpacity = 1
//        containerView.layer.shadowOffset = .zero
//        containerView.layer.shadowRadius = 10
//        containerView.layer.shouldRasterize = true
//        containerView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func setupLabels() {
        SetupViewsManager.setupLabels(with: itemName)
        SetupViewsManager.setupLabels(with: itemDescription)
    }
    
    private func getLikeButtonImage() -> UIImage? {
        if let item = item  {
            if item.isFavorite() == true {
                return UIImage(named: "like")?.withTintColor(StyleGuide.Icons.tintColor)
            }
        }
        return UIImage(named: "like2")?.withTintColor(StyleGuide.Icons.tintColor)
    }
    
    private func getShareButtonImage() -> UIImage? {
        return UIImage(named: "share2")?.withTintColor(StyleGuide.Icons.tintColor)
    }
}
