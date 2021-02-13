//
//  TesteViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 21/10/20.
//

import UIKit
import Kingfisher

//MARK: - HeroDetailsViewController: UIViewController
class HeroDetailsViewController: UIViewController {
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroPublisherNameLabel: UILabel!
    @IBOutlet weak var heroDescriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem?
    
    private var viewModel: HeroDetailsViewModel? = nil
    weak var shareDelegate: ShareAndLikeItemProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shareDelegate = self
        self.updateUIInterface()
        self.setAllIdentifiers()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.updateUIInterface()
        self.setAllIdentifiers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    @IBAction func favoriteHero(_ sender: UIButton) {
        shareDelegate?.like(item: viewModel?.getCellItem())
    }
    
    @IBAction func shareHero(_ sender: UIBarButtonItem) {
        shareDelegate?.share(item: viewModel?.getCellItem())
    }
    
    static func getViewController(_ item: HeroModel?) -> HeroDetailsViewController? {
        guard let viewController = UIStoryboard(name: "HeroDetails", bundle: nil).instantiateInitialViewController() as? HeroDetailsViewController else {
            return nil
        }
        
        viewController.viewModel = HeroDetailsViewModel(with: item)
        return viewController
    }
    
    func getViewModel() -> HeroDetailsViewModel? {
        return self.viewModel
    }
    
    func setViewModel(_ viewModel: HeroDetailsViewModel) {
        self.viewModel = viewModel
        self.updateUIInterface()
    }
}

//MARK: - HeroDetailsViewController: Setup UI
extension HeroDetailsViewController {
    private func setupUI() {
        setupView()
        setupImageView()
        setupLabels()
        setupIcons()
    }
    
    private func setupView() {
        SetupViewsManager.setupView(with: view)
        SetupViewsManager.setupNavigationController(with: navigationController)
        
        let customButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        customButton.setImage(getLikeButtonImage(), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: customButton)
    }
    
    private func setupImageView() {
        SetupViewsManager.setupImageView(with: heroImageView ?? nil)
    }
    
    private func setupLabels() {
        SetupViewsManager.setupLabels(with: heroNameLabel)
        SetupViewsManager.setupLabels(with: heroPublisherNameLabel)
        heroDescriptionTextView.textColor = StyleGuide.Label.labelsDescription
        heroDescriptionTextView.backgroundColor = StyleGuide.View.background
    }
    
    private func setupIcons() {
        favoriteButton?.setImage(getLikeButtonImage(), for: .normal)
    }
    
    private func getLikeButtonImage() -> UIImage? {
        return UIImage(named: "like2")?.withTintColor(StyleGuide.Icons.tintColor)
    }
}
