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
    private let localizationService: LocalizationServiceProtocol = LocalizationService.shared
    
    init() {
        self.service = MainService()
    }
    
    init(with service: MainServiceProtocol) {
        self.service = service
    }
    
    func getTabBarItem(for item: TabBarItemTag) -> UITabBarItem {
        return UITabBarItem(
            title: getTabBarItemTitleName(for: item),
            image: getTabBarItemImage(for: item),
            tag: item.rawValue
        )
    }
    
    func getTabBarItemTitleName(for item: TabBarItemTag) -> String {
        switch item {
        case .heroes:
            return localizationService.getTranslation(for: "main.tabitem.heroes")
        case .comics:
            return localizationService.getTranslation(for: "main.tabitem.comics")
        case .favorites:
            return localizationService.getTranslation(for: "main.tabitem.favorites")
        default:
            return localizationService.getTranslation(for: "main.tabitem.config")
        }
    }
    
    func getTabBarItemImageName(for item: TabBarItemTag) -> String {
        switch item {
        case .heroes:
            return "person.3"
        case .comics:
            return "book"
        case .favorites:
            return "heart"
        default:
            return "gear"
        }
    }
    
    func getTabBarItemImage(for item: TabBarItemTag) -> UIImage? {
        return UIImage(systemName: getTabBarItemImageName(for: item))
    }
    
    func getController(for item: TabBarItemTag) -> UIViewController? {
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
            
            return viewController
        }
        
        return nil
    }
    
    func getController(for item: TabBarItemTag, withNagigation: Bool = true) -> UINavigationController? {
        var navigation: UINavigationController? = nil
        let viewController = getController(for: item)
        
        if let viewController = viewController, withNagigation == true  {
            navigation = UINavigationController(rootViewController: viewController)
        }
        
        return navigation
    }
    
    func isCorrectLoginWith(email: UITextField, password: UITextField) -> Bool {
        return service.isCorrectLoginWith(email: email, password: password)
    }
    
    func getLocalizationService() -> LocalizationService {
        return localizationService as? LocalizationService ?? LocalizationService.shared
    }
    
    func getLoginButtonTitle() -> String {
        return localizationService.getTranslation(for: "main.login")
    }
    
    func getFailedLoginMessage() -> String {
        return localizationService.getTranslation(for: "main.messages.failed-login")
    }
    
    func getPositiveButtonString() -> String {
        return localizationService.getTranslation(for: "main.positive-button")
    }
    
    func getEmailString() -> String {
        return localizationService.getTranslation(for: "main.email")
    }
    
    func getPasswordString() -> String {
        return localizationService.getTranslation(for: "main.password")
    }
    
    func getDontHaveAccountString() -> String {
        return localizationService.getTranslation(for: "main.dont-have-account")
    }
    
    func getCreateAccountButtonTitle() -> String {
        return localizationService.getTranslation(for: "main.create-account")
    }
}
