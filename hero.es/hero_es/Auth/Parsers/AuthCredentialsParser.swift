//
//  AuthCredentialsParser.swift
//  hero_es
//
//  Created by Marivaldo Sena on 13/01/21.
//

import Foundation

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

            let authCredentials = AuthCredentialsModel(
                userId: userId,
                username: username,
                email: email,
                lastLoginAt: Date(timeIntervalSince1970: lastLoginAt),
                registrationDate: Date(timeIntervalSince1970: registrationDate)
            )

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
            let authCredentials = AuthCredentialsModel(
                userId: userId,
                username: username,
                email: email,
                lastLoginAt: lastLoginAt,
                registrationDate: registrationDate
            )
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
