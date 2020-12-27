//
//  AuthModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 13/12/20.
//

import Foundation

enum GetUserFromEnumType {
    case dictionary
    case preferences
}

// MARK: - CreateAuthCredentialsModel
struct CreateAuthCredentialsModel {
    let username: String
    let email: String
    let password: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
}

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

// MARK: - AuthCredentialsParser
struct AuthCredentialsParser {
    private static let defaults = UserDefaults.standard
    
    static func saveUserInPreferences(authCredentials: AuthCredentialsModel) {
        defaults.setValue(authCredentials.userId, forKey: "userId")
        defaults.setValue(authCredentials.username, forKey: "username")
        defaults.setValue(authCredentials.email, forKey: "email")
        defaults.setValue(Date().timeIntervalSince1970, forKey: "lastLoginAt")
        defaults.setValue(Date().timeIntervalSince1970, forKey: "registrationDate")
        defaults.synchronize()
    }
    
    static func getUserFromPreferences() -> AuthCredentialsModel? {
        guard let username = defaults.string(forKey: "username") else { return nil }

        if !username.isEmpty {
            let email = defaults.string(forKey: "email") ?? ""
            let userId = defaults.string(forKey: "userId") ?? ""
            let lastLoginAt = defaults.double(forKey: "lastLoginAt")
            let registrationDate = defaults.double(forKey: "registrationDate")

            let authCredentials = AuthCredentialsModel(userId: userId,
                                            username: username,
                                            email: email,
                                            lastLoginAt: Date(timeIntervalSince1970: lastLoginAt),
                                            registrationDate: Date(timeIntervalSince1970: registrationDate))

            return authCredentials
        }
        
        return nil
    }
    
    static func getUserFrom(dictionary: [String: Any]) -> AuthCredentialsModel? {
        let username = dictionary["username"] as? String ?? ""
        let email = dictionary["email"] as? String ?? ""
        let userId = dictionary["userId"] as? String ?? ""
        let lastLoginAt = dictionary["lastLoginAt"] as? Date ?? Date()
        let registrationDate = dictionary["registrationDate"] as? Date ?? Date()
        
        if !username.isEmpty {
            let authCredentials = AuthCredentialsModel(userId: userId,
                                            username: username,
                                            email: email,
                                            lastLoginAt: lastLoginAt,
                                            registrationDate: registrationDate)
            return authCredentials
        }
        
        return nil
    }
    
    static func clearUserFromPreferences() {
        let keysToRemove = ["userId", "username"]
        
        for key in keysToRemove {
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
}
