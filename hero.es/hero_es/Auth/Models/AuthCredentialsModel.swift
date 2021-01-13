//
//  AuthModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 13/12/20.
//

import Foundation

// MARK: - AuthCredentialsModel
struct AuthCredentialsModel {
    let userId: String
    let username: String
    let email: String
    let lastLoginAt: Date
    let registrationDate: Date
    
    init(userId: String, username: String, email: String, lastLoginAt: Date, registrationDate: Date) {
        self.userId = userId
        self.username = username
        self.email = email
        self.lastLoginAt = lastLoginAt
        self.registrationDate = registrationDate
    }
}
