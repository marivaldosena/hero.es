//
//  ComicsListViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 02/11/20.
//

import UIKit

// MARK: - ComicsListViewController: UIViewController
class ComicsListViewController: UIViewController {
    @IBOutlet weak var comicsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var viewModel = ComicsListViewModel()
    private var modelsArray: [ComicModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getTitleView()
        
        viewModel.delegate = self
        viewModel.loadItems()
        
        comicsTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        comicsTableView.dataSource = self
        comicsTableView.delegate = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadItems()
    }
    
    func updateUIInterface() {
        DispatchQueue.main.async {
            self.comicsTableView.reloadData()
        }
    }
    
    func updateTable(with array: [ComicModel]) {
        modelsArray = array
        updateUIInterface()
    }
    
    func getItem(at index: Int) -> ComicModel {
        return modelsArray[index]
    }
    
    func getNumberOfItems() -> Int {
        return modelsArray.count
    }
    
    private func setupUI() {
        SetupViewsManager.setupView(with: view)
        SetupViewsManager.setupTableView(with: comicsTableView ?? nil)
        SetupViewsManager.setupNavigationController(with: navigationController)
        searchBar.barTintColor = StyleGuide.TableView.background
        searchBar?.roundCorners(cornerRadius: 10, corners: .allCorners)
    }
}
