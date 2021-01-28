//
//  CreateAccountViewModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 27/01/21.
//

import Foundation

struct CreateAccountViewModel {
    private let localizationService: LocalizationServiceProtocol = LocalizationService.shared
    
    func getNameString() -> String {
        return localizationService.getTranslation(for: "create-account.name")
    }
    
    func getEmailString() -> String {
        return localizationService.getTranslation(for: "create-account.email")
    }
    
    func getPasswordString() -> String {
        return localizationService.getTranslation(for: "create-account.password")
    }
    
    func getCreateAccountButtonTitle() -> String {
        return localizationService.getTranslation(for: "create-account.create-account")
    }
    
    func getTermsOfServiceAgreementString() -> String {
        return localizationService.getTranslation(for: "create-account.terms-of-service-agreement")
    }
    
    func getReadmeButtonTitle() -> String {
        return localizationService.getTranslation(for: "create-account.read-the-terms-service")
    }
}
