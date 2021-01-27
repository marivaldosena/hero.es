//
//  LocalizationService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation
import Localize_Swift

protocol LocalizationServiceProtocol {
    func getAvailableLanguages() -> [AvailableLanguage]
    func setCurrent(language: AvailableLanguage)
    func getCurrentLanguage() -> AvailableLanguage
    func getTranslation(for item: String, language: AvailableLanguage) -> String
    func getTranslation(for item: String) -> String
}

class LocalizationService: LocalizationServiceProtocol {
    static var shared = LocalizationService()
    var repository: LocalizationRepositoryProtocol = LocalizationRepository()
    
    private var currentLanguage = AvailableLanguage(languageName: "English", abbreviation: "en")
    
    init() {
        Localize.setCurrentLanguage("en")
    }
    
    func getAvailableLanguages() -> [AvailableLanguage] {
        let modelsArray = LanguageParser.from(Localize.availableLanguages())
        return modelsArray
    }
    
    func setCurrent(language: AvailableLanguage) {
        currentLanguage = language
        Localize.setCurrentLanguage(language.abbreviation)
    }
    
    func getCurrentLanguage() -> AvailableLanguage {
        return currentLanguage
    }
    
    func getTranslation(for item: String, language: AvailableLanguage) -> String {
        return repository.getTranslation(for: item, language: language)
    }
    
    func getTranslation(for item: String) -> String {
        return repository.getTranslation(for: item, language: currentLanguage)
    }
}
