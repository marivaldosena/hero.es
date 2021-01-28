//
//  ConfigLocalizationViewModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation

struct ConfigViewModel {
    var localizationService: LocalizationServiceProtocol = LocalizationService.shared

    init() {}
    
    init(with language: AvailableLanguage) {
        localizationService.setCurrent(language: language)
    }
    
    func getEditUserDataString() -> String {
        return localizationService.getTranslation(for: "config.edituserdata")
    }
    
    func getEmailString() -> String {
        return localizationService.getTranslation(for: "config.email")
    }
    
    func getOldPasswordString() -> String {
        return localizationService.getTranslation(for: "config.old-password")
    }
    
    func getNewPasswordString() -> String {
        return localizationService.getTranslation(for: "config.new-password")
    }
    
    func getConfirmPasswordString() -> String {
        return localizationService.getTranslation(for: "config.confirm-password")
    }
    
    func getChangeDataString() -> String {
        return localizationService.getTranslation(for: "config.change-data")
    }
    
    func getChangeLanguageString() -> String {
        return localizationService.getTranslation(for: "config.change-language")
    }
    
    func getDeleteUserString() -> String {
        return localizationService.getTranslation(for: "config.delete-user")
    }
    
    func getLogoutString() -> String {
        return localizationService.getTranslation(for: "config.logout")
    }
}
