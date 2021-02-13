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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        setupView()
        setupImageView()
        setupLabels()
        setupIcons()
    }
    
    private func setupView() {
        SetupViewsManager.setupView(with: view)
        SetupViewsManager.setupNavigationController(with: navigationController)
    }
    
    private func setupImageView() {
        SetupViewsManager.setupImageView(with: imageView ?? nil)
    }
    
    private func setupLabels() {
        SetupViewsManager.setupLabels(with: comicNameLabel)
        SetupViewsManager.setupLabels(with: comicTypeLabel)
        SetupViewsManager.setupLabels(with: comicPageCountLabel)
        SetupViewsManager.setupLabels(with: comicUpcLabel)
        
        comicDescriptionTextView.textColor = StyleGuide.Label.labelsDescription
        comicDescriptionTextView.backgroundColor = StyleGuide.View.background
    }
    
    private func setupIcons() {
        shareButton?.setImage(getShareButtonImage(), for: .normal)
    }
    
    private func getShareButtonImage() -> UIImage? {
        return UIImage(named: "share2")?.withTintColor(StyleGuide.Icons.tintColor)
    }
}
