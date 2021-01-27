//
//  LanguageParser.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation
import Localize_Swift

struct LanguageParser {
    private static let preferences = UserDefaults.standard
    
    static func from(_ abbreviations: [String]) -> [AvailableLanguage] {
        var modelsArray: [AvailableLanguage] = []
        for abbr in abbreviations {
            if abbr != "Base" {
                let languageName = Localize.displayNameForLanguage(abbr)
                let language = AvailableLanguage(languageName: languageName, abbreviation: abbr)
                modelsArray.append(language)
            }
        }
        return modelsArray
    }
    
    static func fromUserPreferences() -> AvailableLanguage {
        let abbreviation = preferences.string(forKey: "currentLanguage") ?? "en"
        let language = AvailableLanguage(
            languageName: Localize.displayNameForLanguage(abbreviation),
            abbreviation: abbreviation
        )
        return language
    }
    
    static func toUserPreferences(language: AvailableLanguage) {
        preferences.setValue(language.abbreviation, forKey: "currentLanguage")
        preferences.synchronize()
    }
}
