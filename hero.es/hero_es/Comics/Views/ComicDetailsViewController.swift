//
//  ComicDetailsViewController.swift
//  hero_es
//
//  Created by Marivaldo Sena on 05/01/21.
//

import UIKit

class ComicDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var comicNameLabel: UILabel!
    @IBOutlet weak var comicTypeLabel: UILabel!
    @IBOutlet weak var comicDescriptionTextView: UITextView!
    @IBOutlet weak var comicPageCountLabel: UILabel!
    @IBOutlet weak var comicUpcLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem?
    
    private var viewModel: ComicDetailsViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIInterface()
        setupUI()
    }
    
    @IBAction func share(_ sender: UIButton) {
        guard let model = viewModel?.getModel() else { return }
        share(model)
    }
    
    @objc func favorite() {
        print("Favorite item")
    }
    
    static func getController(_ viewModel: ComicDetailsViewModel) -> ComicDetailsViewController? {
        guard let viewController = UIStoryboard(name: "ComicDetails", bundle: nil).instantiateInitialViewController() as? ComicDetailsViewController else { return nil }
        viewController.viewModel = viewModel
        _ = UINavigationController(rootViewController: viewController)
        
        return viewController
    }
    
    func getViewModel() -> ComicDetailsViewModel? {
        return viewModel
    }
}

extension ComicDetailsViewController {
    private func setupUI() {
        setupImageView()
        setupLabels()
    }
    
    private func setupImageView() {
        let cornersToRound: UIRectCorner = [.bottomRight, .bottomLeft]
        imageView.roundCorners(cornerRadius: 30, corners: cornersToRound)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = StyleGuide.Color.gray.cgColor
    }
    
    private func setupLabels() {
        comicNameLabel.textColor = StyleGuide.Color.darkGray
        comicTypeLabel.textColor = StyleGuide.Color.gray
        comicDescriptionTextView.textColor = StyleGuide.Color.gray
        comicPageCountLabel.textColor = StyleGuide.Color.gray
        comicUpcLabel.textColor = StyleGuide.Color.gray
    }
}
