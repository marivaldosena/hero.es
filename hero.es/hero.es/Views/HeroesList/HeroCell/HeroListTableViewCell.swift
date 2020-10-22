//
//  HeroListTableViewCell.swift
//  hero.es
//
//  Created by Marivaldo Sena on 21/10/20.
//

import UIKit

class HeroListTableViewCell: UITableViewCell {
    @IBOutlet weak var heroNameLabel: UILabel?
    @IBOutlet weak var heroDescriptionLabel: UILabel?
    @IBOutlet weak var heroImageView: UIImageView?
    @IBOutlet weak var shareButtonImageView: UIImageView?
    @IBOutlet weak var favoriteButtonImageView: UIImageView?
    
    private var item: Hero? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with item: Hero?) {
        guard let hero = item else { return }
        
        self.item = hero
        self.updateUIInterface()
    }
    
    func updateUIInterface() {
        guard let hero = self.item else {
            self.resetUIInterface()
            return
        }
        
        //TODO: Add functionality to fetch image from Web
        DispatchQueue.main.async {
            self.heroImageView?.image = UIImage(named: hero.imageName)
            self.heroNameLabel?.text = hero.name
            self.heroDescriptionLabel?.text = hero.description
        }
    }
    
    func resetUIInterface() {
        self.heroNameLabel?.text = "Hero Name"
        self.heroDescriptionLabel?.text = "Hero Description"
        self.heroImageView?.image = UIImage(systemName: "person")
        self.shareButtonImageView?.image = UIImage(systemName: "square.and.arrow.up")
        self.favoriteButtonImageView?.image = UIImage(systemName: "heart")
    }
}
