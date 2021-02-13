//
//  AvailableLanguagesOptions.swift
//  hero_es
//
//  Created by Marivaldo Sena on 02/02/21.
//

import Foundation

enum AvailableLanguagesOptions {
    case en
    case ptBr
    
    var languageName: String {
        switch self {
        case .en: return "English"
        case .ptBr: return "Portuguese (Brazil)"
        }
    }
    
    var abbreviation: String {
        switch self {
        case .en: return "en"
        default: return "pt-BR"
        }
    }
}
