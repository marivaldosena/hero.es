//
//  FavoritesViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 02/11/20.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var categoryDescriptionLabel: UILabel!
    var viewModel: FavoritesViewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getTitleView()
        
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.getItems()
        updateUIInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getItems()
        updateUIInterface()
    }
    
    @IBAction func filterFavorites(_ sender: UISegmentedControl) {
        switch sender {
        case filterSegmentedControl:
            filterFavorites()
        default:
            break
        }
    }
    
    private func setupUI() {
        SetupViewsManager.setupView(with: view)
        SetupViewsManager.setupTableView(with: tableView ?? nil)
        SetupViewsManager.setupLabels(with: categoryDescriptionLabel)
        SetupViewsManager.setupNavigationController(with: navigationController)
    }
}
