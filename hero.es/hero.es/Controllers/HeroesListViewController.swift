//
//  HeroesListViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 21/10/20.
//

import UIKit

//MARK: - HeroesListViewController: UIViewController
class HeroesListViewController: UIViewController {
    @IBOutlet weak var heroListTableViewCollection: UITableView?
    
    private var itemsList = HeroSeed.seed()

    override func viewDidLoad() {
        super.viewDidLoad()

        heroListTableViewCollection?.delegate = self
        heroListTableViewCollection?.dataSource = self
        
        heroListTableViewCollection?.register(UINib(nibName: "HeroListTableViewCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
    }
}

extension HeroesListViewController {
    static func getViewController() -> HeroesListViewController? {
        guard let viewController = UIStoryboard(name: "HeroesList", bundle: nil).instantiateInitialViewController() as? HeroesListViewController else {
            return nil
        }
        
        return viewController
    }
}

//MARK: -
extension HeroesListViewController: UITableViewDelegate {
}

extension HeroesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroListTableViewCell
        
        let hero = itemsList[indexPath.row]
        cell.configure(with: hero)
        
        return cell
    }
}
