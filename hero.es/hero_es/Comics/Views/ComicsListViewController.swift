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
        
        viewModel.delegate = self
        viewModel.loadItems()
        
        comicsTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        comicsTableView.dataSource = self
        comicsTableView.delegate = self
        
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func updateUIInterface() {
        DispatchQueue.main.async {
            self.comicsTableView.reloadData()
        }
    }
    
    func updateTable(with array: [ComicModel]) {
        modelsArray = array
    }
    
    func getItem(at index: Int) -> ComicModel {
        return modelsArray[index]
    }
    
    func getNumberOfItems() -> Int {
        return modelsArray.count
    }
}
