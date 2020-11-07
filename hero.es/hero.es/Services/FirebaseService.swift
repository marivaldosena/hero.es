//
//  FirebaseAuthService.swift
//  hero.es
//
//  Created by Marivaldo Sena on 06/11/20.
//

import Foundation
import Firebase
import FirebaseFirestore

typealias SuccessHandlerType = () -> Void
typealias FailureHandlerType = () -> Void
typealias UserDataTupleType = (username: String, email: String, userId: Int, lastLoginAt: Date)

struct FirebaseService {
    private static let db = Firestore.firestore()
    
    static func createAccount(username: String, email: String, password: String, success: SuccessHandlerType?, failure: FailureHandlerType?) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print(error)
                failure?()
            } else {
                if let user = authResult?.user {
                    let db = self.getDatabaseInstance()
                    
                    db.collection("users").addDocument(data: [
                        "userId": user.uid,
                        "username": user.displayName ?? username,
                        "email": user.email ?? email
                    ]) { error in
                        if let error = error {
                            print(error)
                            failure?()
                        } else {
                            success?()
                        }
                    }
                }
            }
        }
    }
    
    static func loginWithEmailAndPassword(_ email: String, _ password: String, success: SuccessHandlerType?, failure: FailureHandlerType?) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print(error)
                failure?()
            } else {
                if let user = authResult?.user {
                    let db = self.getDatabaseInstance()
                    
                    db.collection("users").whereField("userId", isEqualTo: user.uid).getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print(error)
                            failure?()
                        } else {
                            let defaults = UserDefaults.standard
                            defaults.setValue(user.email, forKey: "email")
                            defaults.setValue(user.displayName, forKey: "username")
                            defaults.setValue(user.uid, forKey: "userId")
                            defaults.setValue(Date().timeIntervalSince1970, forKey: "lastLoginAt")
                            
                            success?()
                        }
                    }
                }
            }
        }
    }
    
    static func getDatabaseInstance() -> Firestore {
        return db
    }
    
    static func getCurrentUser() -> UserDataTupleType? {
        let defaults = UserDefaults.standard
        
        let username = defaults.string(forKey: "username") ?? ""
        
        if !username.isEmpty {
            let email = defaults.string(forKey: "email") ?? ""
            let userId = defaults.integer(forKey: "userId")
            let lastLoginAt = defaults.double(forKey: "lastLoginAt")
            
            let user = (username: username, email: email, userId: userId, lastLoginAt: Date(timeIntervalSince1970: lastLoginAt))
            
            return user
        }
        
        return nil
    }
}
