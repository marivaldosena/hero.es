//
//  LocalizationService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation
import Localize_Swift

protocol UpdateLanguageProtocol: class {
    func languageDidChange(_ language: AvailableLanguage)
}

// MARK: - LocalizationService: LocalizationServiceProtocol
class LocalizationService: LocalizationServiceProtocol {
    static var shared = LocalizationService()
    var repository: LocalizationRepositoryProtocol = LocalizationRepository()
    private var observers: [UpdateLanguageProtocol?] = []
    
    private var currentLanguage = AvailableLanguage(languageName: "English", abbreviation: "en")
    
    private init() {
        currentLanguage = getLanguageFromUserPreferences()
        notifyObservers()
    }
    
    // MARK: - Public Methods
    func getAvailableLanguages() -> [AvailableLanguage] {
        let modelsArray = LanguageParser.from(Localize.availableLanguages())
        return modelsArray
    }
    
    func setCurrent(language: AvailableLanguage) {
        saveLanguageInUserPreferences(language: language)
        currentLanguage = language
        Localize.setCurrentLanguage(currentLanguage.abbreviation)
        notifyObservers()
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
    
    func addObserver(_ observer: UpdateLanguageProtocol?) {
        self.observers.append(observer)
    }
    
    // MARK: - Private Methods
    private func getLanguageFromUserPreferences() -> AvailableLanguage {
        return LanguageParser.fromUserPreferences()
    }
    
    private func saveLanguageInUserPreferences(language: AvailableLanguage) {
        LanguageParser.toUserPreferences(language: language)
    }
    
    private func notifyObservers() {
        for delegate in observers {
            delegate?.languageDidChange(currentLanguage)
        }
    }
}
