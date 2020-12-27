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
    
    private var itemsList: [HeroModel] = []
    private var viewModel = HeroesListViewModel()
    private let service = HeroService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadAllHeroes()
        
        heroTableView?.delegate = self
        heroTableView?.dataSource = self
        heroTableView?.register(
            UINib(nibName: "HeroListTableViewCell", bundle: nil),
            forCellReuseIdentifier: "HeroCell")
        
        heroSearchBar?.delegate = self
    }
}

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
    
    func goToDetails(_ item: HeroModel) {
        if let viewController = HeroDetailsViewController.getViewController(item) {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

//MARK: - HeroesListViewController: UITableViewDelegate
extension HeroesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - HeroesListViewController: UITableViewDataSource
extension HeroesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroListTableViewCell
        
        let hero = itemsList[indexPath.row]
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
        itemsList = viewModel.search(term: term)
        self.updateUIInterface()
    }
}

// MARK: - HeroesListViewController: HeroListDelegate
extension HeroesListViewController: HeroListDelegate {
    func getItemsListDidFinish(_ heroes: [HeroModel], _ error: Error?) {
        itemsList = heroes
        self.updateUIInterface()
    }
}

// MARK: - HeroesListViewController: ShareHeroItemProtocol
extension HeroesListViewController: ShareHeroItemProtocol {
    func shareHeroItem(_ item: HeroModel) {
        guard let heroUrl = URL(string: item.resourceURI) else { return }
        let heroImage = UIImageView()
        
        if let imageUrl = URL(string: item.thumbnail.url) {
            heroImage.kf.indicatorType = .activity
            heroImage.kf.setImage(with: imageUrl)
        }

        guard let image = heroImage.image else { return }
        
        let itemsToShare = [item.name, heroUrl, image] as [Any]
        let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }
}
