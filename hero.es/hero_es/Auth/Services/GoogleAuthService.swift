//
//  GoogleAuthService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 15/01/21.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

// MARK: - GoogleAuthService: AuthService
class GoogleAuthService: AuthService {
    private let googleInstance = GIDSignIn.sharedInstance()
    
    // MARK: - Public Methods
    func loginWithGoogle(_ viewController: UIViewController, _ completion: @escaping AuthCompletionHandlerType) {
        doInitialConfig(viewController)
        
        loadGoogleCredentials(from: viewController) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
               //completion(nil, error)
            }
            
            if let user = user {
                guard let authentication = user.authentication else { return }
                let credential = GoogleAuthProvider.credential(
                    withIDToken: authentication.idToken,
                    accessToken: authentication.accessToken
                )
                
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                    
                    if let username = authResult?.user.displayName,
                        let uid = authResult?.user.uid,
                        let email = authResult?.user.email {
                        
                        let createCredentials = CreateAuthCredentialsModel(
                            username: username,
                            email: email,
                            password: ""
                        )
                        
                        super.createAccount(createCredentials: createCredentials, userId: uid) { (authCredentials, error) in
                            completion(authCredentials, error)
                        }
                    } else {
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func doInitialConfig(_ viewController: UIViewController) {
        googleInstance?.presentingViewController = viewController
        googleInstance?.delegate = viewController
        googleInstance?.clientID = FirebaseApp.app()?.options.clientID
    }
    
    private func loadGoogleCredentials(from viewController: UIViewController, _ completion: @escaping (_ user: GIDGoogleUser?, _ error: Error?) -> Void) {
        googleInstance?.signIn()

        guard let user = googleInstance?.currentUser else {
            print("Uh oh. The user cancelled the Google login.")
            completion(nil, AuthErrorEnumType.googleLoginError)
            return
        }
        
        completion(user, nil)
    }
}

// MARK: - GoogleAuthService: GIDSignInDelegate
extension UIViewController: GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
          return
        }
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        print("Signing out from Google")
    }
}
