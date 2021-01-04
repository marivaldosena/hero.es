//
//  MainViewModel.swift
//  hero.es
//
//  Created by Marivaldo Sena on 13/12/20.
//

import Foundation
import UIKit

// MARK: - MainViewModel
struct MainViewModel {
    private let service: MainServiceProtocol
    
    init() {
        self.service = MainService()
    }
    
    init(with service: MainServiceProtocol) {
        self.service = service
    }
    
    func getString(for message: MessageType) -> String {
        return message.rawValue
    }
    
    func getTabBarItem(for item: TabBarItemTag) -> UITabBarItem {
        let tabBarItem: UITabBarItem
        
        switch item {
        case .heroes:
            tabBarItem = UITabBarItem(
                title: "Heroes",
                image: UIImage(systemName: "person.3"),
                tag: item.rawValue
            )
        case .comics:
            tabBarItem = UITabBarItem(
                title: "Comics",
                image: UIImage(systemName: "book"),
                tag: item.rawValue
            )
        case .favorites:
            tabBarItem = UITabBarItem(
                title: "Favorites",
                image: UIImage(systemName: "heart"),
                tag: item.rawValue
            )
        default:
            tabBarItem = UITabBarItem(
                title: "Config",
                image: UIImage(systemName: "gear"),
                tag: item.rawValue
            )
        }
        
        return tabBarItem
    }
    
    func getController(for item: TabBarItemTag, withNagigation: Bool = true) -> UIViewController? {
        
        let storyBoardName: String
        
        switch item {
        case .heroes:
            storyBoardName = "HeroesList"
        case .comics:
            storyBoardName = "ComicsList"
        case .favorites:
            storyBoardName = "Favorites"
        case .config:
            storyBoardName = "Config"
        default:
            storyBoardName = "HeroesList"
        }
        
        
        if let viewController = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController() {
            viewController.tabBarItem = getTabBarItem(for: item)
            
            if withNagigation {
                _ = UINavigationController(rootViewController: viewController)
                viewController.title = storyBoardName
            }
            
            return viewController
        }
        
        return nil
    }
    
    func isCorrectLoginWith(email: UITextField, password: UITextField) -> Bool {
        return service.isCorrectLoginWith(email: email, password: password)
    }
}
