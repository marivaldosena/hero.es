//
//  LocalizationRepository.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation

protocol LocalizationRepositoryProtocol {
    func getTranslation(for item: String, language: AvailableLanguage) -> String
}

struct LocalizationRepository: LocalizationRepositoryProtocol {
    func getTranslation(for item: String, language: AvailableLanguage) -> String {
        return item.localized()
//        switch language.abbreviation {
//        case "pt-BR": return getTranslationForBrazilianPortuguese(item: item)
//        default: return getTranslationForEnglish(item: item)
//        }
    }
    
//    private func getTranslationForEnglish(item: String) -> String {
//        return item.localized()
//    }
//
//    private func getTranslationForBrazilianPortuguese(item: String) -> String {
//        return item.localized()
//    }
}
