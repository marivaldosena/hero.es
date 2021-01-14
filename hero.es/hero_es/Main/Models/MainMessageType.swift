//
//  MessageEnumType.swift
//  hero_es
//
//  Created by Marivaldo Sena on 04/01/21.
//

import Foundation

// MARK: - MessageType: String
enum MainMessageType: String {
    case defaultMessage = "Loading"
    case failedLoginMessage = "Login and/or password are wrong."
    case loginButtonTitle = "Login"
    case positiveButton = "OK"
    case heroesTitle = "Heroes"
    case comicsTitle = "Comics"
    case favoritesTitle = "Favorites"
    case configTitle = "Config"
}
