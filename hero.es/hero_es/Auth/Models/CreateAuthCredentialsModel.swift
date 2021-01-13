//
//  CreateAuthCredentialsModel.swift
//  hero_es
//
//  Created by Marivaldo Sena on 13/01/21.
//

import Foundation

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
