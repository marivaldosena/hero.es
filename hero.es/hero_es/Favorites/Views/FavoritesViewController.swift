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
    var viewModel: FavoritesViewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.getItems()
        updateUIInterface()
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
}
