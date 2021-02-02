//
//  LocalizationServiceProtocol.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation

protocol LocalizationServiceProtocol {
    func getAvailableLanguages() -> [AvailableLanguage]
    func setLanguage(language: AvailableLanguagesOptions)
    func setCurrent(language: AvailableLanguage)
    func getCurrentLanguage() -> AvailableLanguage
    func getTranslation(for item: String, language: AvailableLanguagesOptions) -> String
    func getTranslation(for item: String, language: AvailableLanguage) -> String
    func getTranslation(for item: String) -> String
}
