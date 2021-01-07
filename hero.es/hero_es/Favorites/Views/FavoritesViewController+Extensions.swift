//
//  FavoritesViewController+Extensions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 07/01/21.
//

import Foundation
import UIKit

// MARK: - FavoritesViewController
extension FavoritesViewController {
    func updateUIInterface() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func filterFavorites(option: SearchItemType) {
        viewModel.getItems(itemType: option)
        updateUIInterface()
    }
}

// MARK: - FavoritesViewController: UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FavoritesViewController: UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let model = viewModel.getItem(at: indexPath.row)
        cell.configure(with: model)
        
        return cell
    }
}
