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
    // MARK: - Public Methods
    func updateUIInterface() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateSegmentedControlTitles()
            self.favoritesLabel?.text = self.viewModel.getFavoritesLabelString()
        }
    }
    
    func filterFavorites() {
        let selectedOption = filterSegmentedControl.selectedSegmentIndex
        let option: SearchItemType
        
        switch selectedOption {
        case 1:
            option = .hero
        case 2:
            option = .comic
        default:
            option = .all
        }
        viewModel.getItems(itemType: option, in: .firebase)
        updateUIInterface()
    }
    
    // MARK: - Private Methods
    private func updateSegmentedControlTitles() {
        filterSegmentedControl.setTitle(viewModel.getSegmentTitle(for: .all), forSegmentAt: 0)
        filterSegmentedControl.setTitle(viewModel.getSegmentTitle(for: .hero), forSegmentAt: 1)
        filterSegmentedControl.setTitle(viewModel.getSegmentTitle(for: .comic), forSegmentAt: 2)
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
        cell.delegate = self
        return cell
    }
}

// MARK: - FavoritesViewController: ShareAndLikeItemProtocol
extension FavoritesViewController: ShareAndLikeItemProtocol {
    func share(item: CellItemProtocol?) {
        guard let item = item else { return }
        ShareItemUtils.share(item, on: self)
    }
    
    func like(item: CellItemProtocol?) {
        guard let item = item else { return }
        guard let model = FavoriteParser.from(item) else { return }
        let service = FavoriteService.shared
        service.toggleFavorite(model, in: .firebase)
        filterFavorites()
    }
}

// MARK: - FavoritesViewController: UpdateLanguageProtocol
extension FavoritesViewController: UpdateLanguageProtocol {
    func languageDidChange(_ language: AvailableLanguage) {
        updateUIInterface()
    }
}
