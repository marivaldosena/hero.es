//
//  MockMainService.swift
//  hero_esTests
//
//  Created by Marivaldo Sena on 04/01/21.
//
import Foundation
import UIKit
@testable import hero_es

struct MockMainService: MainServiceProtocol {
    func loginWithEmailAndPassword(_ email: String, _ password: String, _ completion: @escaping (AuthCredentialsModel?, Error?) -> Void) {
        if email == "john.doe@email.com" && password == "123456" {
            let authCredentials: AuthCredentialsModel = AuthCredentialsModel(
                userId: "1",
                username: "John Doe",
                email: "john.doe@email.com",
                lastLoginAt: Date(timeIntervalSince1970: 1609754400), // 2021-01-04 10:00hs
                registrationDate: Date(timeIntervalSince1970: 1609495200) // 2021-01-01 10:00hs
            )
            completion(authCredentials, nil)
        } else {
            completion(
                nil,
                .some(
                    NSError(
                        domain: "MockMainService",
                        code: 1,
                        userInfo: ["error": "Login error"]
                    )
                )
            )
        }
    }
    
    func isCorrectLoginWith(email: UITextField, password: UITextField) -> Bool {
        if let email = email.text, let password = password.text {
            return email == "john.doe@email.com" && password == "123456"
        }
        
        return false
    }
}
