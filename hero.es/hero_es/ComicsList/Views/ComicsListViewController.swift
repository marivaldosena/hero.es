//
//  ComicsListViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 02/11/20.
//

import UIKit

class ComicsListViewController: UIViewController {
    @IBOutlet weak var comicsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var viewModel = ComicsListViewModel()
    var modelsArray: [ComicModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadAllItems()
        comicsTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        comicsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - ComicsListViewController: ComicsListDelegate
extension ComicsListViewController: ComicsListDelegate {
    func getItemsListDidLoad(_ items: [ComicModel], _ error: Error?) {
        modelsArray = items
    }
}

// MARK: - ComicsListViewController: UITableViewDataSource
extension ComicsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let model = viewModel.getItem(at: indexPath.row)
        cell.configure(with: model)
        cell.imageHolder = viewModel
        return cell
    }
}
