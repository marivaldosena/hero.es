//
//  FacebookAuthService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 14/01/21.
//

import Foundation
import UIKit
import Firebase
import FBSDKLoginKit

protocol FacebookAuthServiceProtocol: AuthServiceProtocol {
    func loginWithFacebook(_ viewController: UIViewController, _ completion: @escaping AuthCompletionHandlerType)
}

class FacebookAuthService: AuthService, FacebookAuthServiceProtocol {
    func loginWithFacebook(_ viewController: UIViewController, _ completion: @escaping AuthCompletionHandlerType) {
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { (result, error) in
            guard error == nil else {
                // Error occurred
                print(error!.localizedDescription)
                return
            }
            
            guard let result = result, !result.isCancelled else {
                print("User cancelled login")
                return
            }
            
            if let accessToken = AccessToken.current {
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    print("Just logged in")
                    
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
}
