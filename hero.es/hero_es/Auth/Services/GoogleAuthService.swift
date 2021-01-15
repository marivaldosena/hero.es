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
    func loginWithGoogle(_ viewController: UIViewController) {
        doInitialConfig(viewController)
        googleInstance?.signIn()
    }
    
    // MARK: - Private Methods
    private func doInitialConfig(_ viewController: UIViewController) {
        googleInstance?.presentingViewController = viewController
        googleInstance?.delegate = viewController
        googleInstance?.clientID = FirebaseApp.app()?.options.clientID
    }
}

// MARK: - GoogleAuthService: GIDSignInDelegate
extension UIViewController: GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
          return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )
        print(credential.provider)
        guard let user = user else {
            print("Uh oh. The user cancelled the Google login.")
            return
        }
        let userId = user.userID ?? ""
        print("Google User ID: \(userId)")
        
        let userIdToken = user.authentication.idToken ?? ""
        print("Google ID Token: \(userIdToken)")
        
        let userFirstName = user.profile.givenName ?? ""
        print("Google User First Name: \(userFirstName)")
        
        let userLastName = user.profile.familyName ?? ""
        print("Google User Last Name: \(userLastName)")
        
        let userFullName = "\(userFirstName) \(userLastName)"
        print("Google User Full Name: \(userFullName)")
        
        let userEmail = user.profile.email ?? ""
        print("Google User Email: \(userEmail)")
        
        let googleProfilePicURL = user.profile.imageURL(withDimension: 150)?.absoluteString ?? ""
        print("Google Profile Avatar URL: \(googleProfilePicURL)")
        
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        print("Signing out from Google")
    }
}

