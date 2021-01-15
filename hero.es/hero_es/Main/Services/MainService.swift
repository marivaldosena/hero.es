//
//  MainService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 04/01/21.
//

import Foundation
import UIKit

protocol MainServiceProtocol {
    func isCorrectLoginWith(email: UITextField, password: UITextField) -> Bool
    func loginWithEmailAndPassword(_ email: String, _ password: String, _ completion: @escaping (_ user: AuthCredentialsModel?, _ error: Error?) -> Void)
}

struct MainService: MainServiceProtocol {
    static var shared: MainService = MainService()
    
    func isCorrectLoginWith(email: UITextField, password: UITextField) -> Bool {
        return ValidatorService.isEmailValid(email) && ValidatorService.isPasswordValid(password)
    }
    
    func loginWithEmailAndPassword(
        _ email: String,
        _ password: String,
        _ completion: @escaping (_ user: AuthCredentialsModel?, _ error: Error?) -> Void) {
        EmailAuthService.shared.loginWithEmailAndPassword(email, password, completion)
    }
}
