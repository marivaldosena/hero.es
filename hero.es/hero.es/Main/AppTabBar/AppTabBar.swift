//
//  AppTabBar.swift
//  hero.es
//
//  Created by Marivaldo Sena on 23/10/20.
//

import UIKit

class AppTabBar: UITabBar {
    @IBOutlet weak var heroesTabBarItem: UITabBarItem?
    @IBOutlet weak var comicsTabBarItem: UITabBarItem?
    @IBOutlet weak var favoritesTabBarItem: UITabBarItem?
    @IBOutlet weak var configTabBarItem: UITabBarItem?

    @IBAction func tabBarItemWasClicked(_ sender: UITabBarItem) {
        
        switch (sender) {
        case heroesTabBarItem:
            self.goToHeroes()
        case comicsTabBarItem:
            self.goToComics()
        case favoritesTabBarItem:
            self.goToFavorites()
        case configTabBarItem:
            self.goToConfiguration()
        default:
            break
        }
    }
    
    private func goToHeroes() {
        print("Go To Heroes")
    }
    
    private func goToComics() {
        print("Go To Comics")
    }
    
    private func goToFavorites() {
        print("Go To Favorites")
    }
    
    private func goToConfiguration() {
        print("Go To Configuration")
    }
}
