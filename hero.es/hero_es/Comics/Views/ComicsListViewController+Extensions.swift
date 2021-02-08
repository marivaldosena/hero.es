//
//  ComicsListViewController+Extensions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 02/01/21.
//

import Foundation
import UIKit

// MARK: - ComicsListViewController: ComicsListDelegate
extension ComicsListViewController: ComicsListDelegate {
    func getItemsListDidLoad(_ items: [ComicModel], _ error: Error?) {
        updateTable(with: items)
        self.updateUIInterface()
    }
}

// MARK: - ComicsListViewController: UITableViewDelegate
extension ComicsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel.getItem(at: indexPath.row) else { return }
        let detailsViewModel = ComicDetailsViewModel(with: model)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let controller = ComicDetailsViewController.getController(detailsViewModel) else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - ComicsListViewController: UITableViewDataSource
extension ComicsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let model = viewModel.getItem(at: indexPath.row)
        cell.configure(with: model, itemType: .comic)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

// MARK: - ComicsListViewController: ShareAndLikeItemProtocol
extension ComicsListViewController: ShareAndLikeItemProtocol {
    func share(item: CellItemProtocol?) {
        guard let item = item else { return }
        ShareItemUtils.share(item, on: self)
    }
    
    func like(item: CellItemProtocol?) {
        guard let item = item else { return }
        let service = FavoriteService.shared
        service.toggleFavorite(item, itemType: .comic, in: .firebase)
        updateUIInterface()
    }
}

// MARK: - ComicsListViewController: UISearchBarDelegate
extension ComicsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        doSearch()
        updateUIInterface()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        doSearch()
        searchBar.resignFirstResponder()
        updateUIInterface()
    }
    
    private func doSearch() {
        if let term = searchBar.text {
            updateTable(with: viewModel.getItems(term: term))
        } else {
            updateTable(with: viewModel.getItems())
        }
    }
}
