//
//  HeroesListViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 21/10/20.
//

import UIKit
import Kingfisher

//MARK: - HeroesListViewController: UIViewController
class HeroesListViewController: UIViewController {
    @IBOutlet weak var heroTableView: UITableView?
    @IBOutlet weak var heroSearchBar: UISearchBar?
    
    var viewModel = HeroesListViewModel()
    private let service = HeroService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getTitleView()
        
        setupUI()
        
        viewModel.delegate = self
        let offset = Int.random(in: 0..<100)
        viewModel.loadAllHeroes(limit: 0, offset: offset)
        
        heroTableView?.delegate = self
        heroTableView?.dataSource = self
        heroTableView?.register(
            UINib(nibName: "ItemCell", bundle: nil),
            forCellReuseIdentifier: "ItemCell")
        
        heroSearchBar?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let offset = Int.random(in: 0..<100)
        viewModel.loadAllHeroes(limit: 0, offset: offset)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let offset = Int.random(in: 0..<100)
        viewModel.loadAllHeroes(limit: 0, offset: offset)
    }
    
    private func setupUI() {
        SetupViewsManager.setupView(with: view)
        SetupViewsManager.setupTableView(with: heroTableView ?? nil)
        SetupViewsManager.setupNavigationController(with: navigationController)
        heroSearchBar?.backgroundColor = StyleGuide.TableView.background
        heroSearchBar?.roundCorners(cornerRadius: 10, corners: .allCorners)
    }
}
