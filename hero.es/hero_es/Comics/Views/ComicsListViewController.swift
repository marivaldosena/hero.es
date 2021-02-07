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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getTitleView()
        
        setupUI()
        
        viewModel.delegate = self
        viewModel.loadItems()
        
        comicsTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        comicsTableView.dataSource = self
        comicsTableView.delegate = self
        
        searchBar.delegate = self
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
        updateUIInterface()
    }
    
    func getNumberOfItems() -> Int {
        return viewModel.getNumberOfItems()
    }
    
    private func setupUI() {
        view.backgroundColor = StyleGuide.Color.lightSecondaryGray
        
        comicsTableView?.roundCorners(cornerRadius: 15, corners: .allCorners)
        comicsTableView?.backgroundColor = StyleGuide.Color.lightGray
        comicsTableView.separatorStyle = .none
        
        searchBar?.backgroundColor = StyleGuide.Color.white
        searchBar?.roundCorners(cornerRadius: 10, corners: .allCorners)
    }
}
