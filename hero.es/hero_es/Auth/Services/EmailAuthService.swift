//
//  AuthService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 13/12/20.
//

import Foundation
import Firebase

// MARK: - AuthService
class EmailAuthService: AuthService {
    override func createAccount(createCredentials: CreateAuthCredentialsModel, userId: String? = nil, completion: @escaping AuthCompletionHandlerType) {
        Auth.auth().createUser(withEmail: createCredentials.email, password: createCredentials.password) { (authResult, error) in
            if let error = error {
                completion(nil, error)
            }

            guard let authResult = authResult else {
                completion(nil, error)
                return
            }

            let user = authResult.user
            let username = user.displayName ?? createCredentials.username
            let email = user.email ?? createCredentials.email
            
            let createWithUserData = CreateAuthCredentialsModel(
                username: username,
                email: email,
                password: createCredentials.password
            )
            
            super.createAccount(createCredentials: createWithUserData, userId: userId, completion: { (authCredentials, error) in
                if let error = error {
                    completion(nil, error)
                }
                
                if let authCredentials = authCredentials {
                    completion(authCredentials, nil)
                }
            })
        }
    }
    
    override func loginWithEmailAndPassword(
        _ email: String,
        _ password: String,
        _ completion: @escaping AuthCompletionHandlerType
    ) {
        super.loginWithEmailAndPassword(email, password, completion)
    }
}
