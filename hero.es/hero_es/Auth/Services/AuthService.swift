//
//  AuthService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 13/12/20.
//

import Foundation
import Firebase

// MARK: - Handler Types
typealias AuthCompletionHandlerType = (_ user: AuthCredentialsModel?, _ error: Error?) -> Void
typealias CompletionWithNullableErrorHandlerType = (_ isFinished: Bool, _ error: Error?) -> Void

// MARK: - AuthService
struct AuthService {
    private let db = Firestore.firestore()
    static let shared = AuthService()
    
    // MARK: - Public Methods
    func createAccount(createCredentials: CreateAuthCredentialsModel, completion: @escaping AuthCompletionHandlerType) {
        Auth.auth().createUser(withEmail: createCredentials.email,
                               password: createCredentials.password) { (authResult, error) in
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
            let registrationDate = Date()
            
            let authCredentials = AuthCredentialsModel(userId: user.uid,
                                                       username: username,
                                                       email: email,
                                                       lastLoginAt: registrationDate,
                                                       registrationDate: registrationDate)

            
            self.insertCreatedUserToUserTable(authCredentials: authCredentials) { isFinished, error in
                if let error = error { completion(nil, error) }
            }
            
            self.saveUserDataInPreferences(authCredentials: authCredentials)
            
            completion(authCredentials, nil)
        }
    }
    
    func getCurrentUser() -> AuthCredentialsModel? {
        return AuthCredentialsParser.getUserFromPreferences()
    }
    
    func loginWithEmailAndPassword(_ email: String, _ password: String, _ completion: @escaping AuthCompletionHandlerType) {
        loginWith(email: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else {
                completion(nil, error)
                return
            }
            
            if let error = error {
                completion(nil, error)
            }
            
            let userDocument = self.db.collection("users").document(user.uid)
            
            userDocument.getDocument { (document, error) in
                
                if let error = error { completion(nil, error) }
                guard let document = document, document.exists else {
                    completion(nil, error)
                    return
                }
                
                let data: [String: Any] = document.data() ?? [:]
                guard let authCredentials = AuthCredentialsParser.getUserFrom(dictionary: data) else {
                    completion(nil, error)
                    return
                }
        
                userDocument.updateData(["lastLoginAt": Date().timeIntervalSince1970]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
                self.saveUserDataInPreferences(authCredentials: authCredentials)
                completion(authCredentials, nil)
            }
        }
    }
    
    func logout(completion: CompletionWithNullableErrorHandlerType) {
        do {
            try Auth.auth().signOut()
            AuthCredentialsParser.clearUserFromPreferences()
            completion(true, nil)
        } catch let error {
            completion(true, error)
        }
    }
    
    func update(email oldEmail: String, withPassword oldPassword: String, completion: @escaping AuthCompletionHandlerType) {
        // TODO: Implement this logic
    }
    
    // MARK: - Private Methods
    private func insertCreatedUserToUserTable(authCredentials: AuthCredentialsModel,
                                              completion: @escaping CompletionWithNullableErrorHandlerType) {
        let data: [String: Any] = [
            "userId": authCredentials.userId,
            "username": authCredentials.username,
            "email": authCredentials.email,
            "lastLoginAt": Date().timeIntervalSince1970,
            "registrationDate": Date().timeIntervalSince1970
        ]
        
        db.collection("users").document(authCredentials.userId).setData(data) { error in
            if let error = error {
                completion(true, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    private func saveUserDataInPreferences(authCredentials: AuthCredentialsModel) {
        AuthCredentialsParser.saveUserInPreferences(authCredentials: authCredentials)
    }
    
    private func loginWith(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
