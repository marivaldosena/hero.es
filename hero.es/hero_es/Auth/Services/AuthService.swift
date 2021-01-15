//
//  AuthService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 14/01/21.
//

import Foundation
import Firebase

// MARK: - Handler Types
typealias AuthCompletionHandlerType = (_ user: AuthCredentialsModel?, _ error: Error?) -> Void
typealias CompletionWithNullableErrorHandlerType = (_ isFinished: Bool, _ error: Error?) -> Void

// MARK: - AuthServiceProtocol
protocol AuthServiceProtocol {
    func createAccount(createCredentials: CreateAuthCredentialsModel, userId: String?, completion: @escaping AuthCompletionHandlerType)
    func getCurrentUser() -> AuthCredentialsModel?
    func logout(completion: CompletionWithNullableErrorHandlerType)
}

// MARK: - AuthService
class AuthService: AuthServiceProtocol {
    private let db = Firestore.firestore()
    static var shared = AuthService()
    
    // MARK: - Public Methods
    func createAccount(createCredentials: CreateAuthCredentialsModel, userId: String? = nil, completion: @escaping AuthCompletionHandlerType) {
        let username = createCredentials.username
        let email = createCredentials.email
        let registrationDate = Date()
        
        let authCredentials = AuthCredentialsModel(
            userId: userId,
            username: username,
            email: email,
            lastLoginAt: registrationDate,
            registrationDate: registrationDate
        )
        
        self.insertCreatedUserToUserTable(authCredentials: authCredentials) { isFinished, error in
            if let error = error { completion(nil, error) }
        }
        
        self.saveUserDataInPreferences(authCredentials: authCredentials)
        
        completion(authCredentials, nil)
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
        if let userId = authCredentials.userId {
            let data: [String: Any] = [
                "userId": userId,
                "username": authCredentials.username,
                "email": authCredentials.email,
                "lastLoginAt": Date().timeIntervalSince1970,
                "registrationDate": Date().timeIntervalSince1970
            ]
            
            db.collection("users").document(userId).setData(data) { error in
                if let error = error {
                    completion(true, error)
                } else {
                    completion(true, nil)
                }
            }
        } else {
            completion(false, AuthErrorEnumType.noUidAvailable)
        }
    }
    
    private func saveUserDataInPreferences(authCredentials: AuthCredentialsModel) {
        AuthCredentialsParser.saveUserInPreferences(authCredentials: authCredentials)
    }
    
    private func loginWith(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
