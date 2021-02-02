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
        
//        setupUI()
        
        viewModel.delegate = self
        viewModel.loadAllHeroes()
        
        heroTableView?.delegate = self
        heroTableView?.dataSource = self
        heroTableView?.register(
            UINib(nibName: "ItemCell", bundle: nil),
            forCellReuseIdentifier: "ItemCell")
        
        heroSearchBar?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadAllHeroes()
    }
    
    private func setupUI() {
        view.backgroundColor = StyleGuide.View.background
        
        heroTableView?.roundCorners(cornerRadius: 15, corners: .allCorners)
        heroTableView?.backgroundColor = StyleGuide.Color.lightGray
        heroTableView?.separatorStyle = .none
        
        heroSearchBar?.backgroundColor = StyleGuide.Color.white
        heroSearchBar?.roundCorners(cornerRadius: 10, corners: .allCorners)
    }
}
