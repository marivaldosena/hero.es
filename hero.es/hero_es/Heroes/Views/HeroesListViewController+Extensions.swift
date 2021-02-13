//
//  HeroesListViewController+Extensions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation
import UIKit

// MARK: - HeroesListViewController
extension HeroesListViewController {
    static func getViewController() -> HeroesListViewController? {
        guard let viewController = UIStoryboard(name: "HeroesList", bundle: nil).instantiateInitialViewController() as? HeroesListViewController else {
            return nil
        }
        
        return viewController
    }
    
    func updateUIInterface() {
        DispatchQueue.main.async {
            self.heroTableView?.reloadData()
        }
    }
    
    func goToDetails(_ item: HeroModel?) {
        if let viewController = HeroDetailsViewController.getViewController(item) {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

//MARK: - HeroesListViewController: UITableViewDelegate
extension HeroesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.getItem(at: indexPath.row)
        viewModel.setActiveHero(item)
        goToDetails(item)
    }
}

//MARK: - HeroesListViewController: UITableViewDataSource
extension HeroesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let hero = viewModel.getItem(at: indexPath.row)
        cell.configure(with: hero)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - HeroesListViewController: UISearchBarDelegate
extension HeroesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let term = searchBar.text else { return }
        self.doHeroesSearch(term: term)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else { return }
        self.doHeroesSearch(term: term)
        searchBar.resignFirstResponder()
    }
    
    private func doHeroesSearch(term: String) {
        viewModel.search(term: term, in: .coreData)
        self.updateUIInterface()
    }
}

// MARK: - HeroesListViewController: HeroListDelegate
extension HeroesListViewController: HeroListDelegate {
    func getItemsListDidFinish(_ heroes: [HeroModel], _ error: Error?) {
        self.updateUIInterface()
    }
}

// MARK: - HeroesListViewController: ShareAndLikeItemProtocol
extension HeroesListViewController: ShareAndLikeItemProtocol {
    func share(item: CellItemProtocol?) {
        guard let item = item else { return }
        ShareItemUtils.share(item, on: self)
    }
    
    func like(item: CellItemProtocol?) {
        guard let item = item else { return }
        let service = FavoriteService.shared
        service.toggleFavorite(item, itemType: .hero, in: .firebase)
        updateUIInterface()
    }
}

// MARK: - HeroesListViewController: UpdateLanguageProtocol
extension HeroesListViewController: UpdateLanguageProtocol {
    func languageDidChange(_ language: AvailableLanguage) {
        updateUIInterface()
    }
}
