//
//  FirebaseAuthService.swift
//  hero.es
//
//  Created by Marivaldo Sena on 06/11/20.
//

import Foundation
import Firebase
import FirebaseFirestore

typealias successHandlerType = () -> Void
typealias failureHandlerType = () -> Void

struct FirebaseService {
    private static let db = Firestore.firestore()
    
    static func createAccount(username: String, email: String, password: String, success: successHandlerType?, failure: failureHandlerType?) {
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
    
    static func loginWithEmailAndPassword(_ email: String, _ password: String) -> User? {
        var loggedInUser: User? = nil
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print(error)
            } else {
                if let user = authResult?.user {
                    let db = self.getDatabaseInstance()
                    
                    db.collection("users").whereField("userId", isEqualTo: user.uid).getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print(error)
                        } else {
                            let defaults = UserDefaults.standard
                            defaults.setValue(user.email, forKey: "email")
                            defaults.setValue(user.displayName, forKey: "username")
                            defaults.setValue(user.uid, forKey: "userId")
                            defaults.setValue(Date(), forKey: "lastLoginAt")
                            
                            loggedInUser = user
                        }
                    }
                }
            }
        }
        return loggedInUser
    }
    
    static func getDatabaseInstance() -> Firestore {
        return db
    }
}
