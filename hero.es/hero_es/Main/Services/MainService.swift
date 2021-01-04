//
//  MainService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 04/01/21.
//

import Foundation
import UIKit

struct MainService {
    func isCorrectLoginWith(email: UITextField, password: UITextField) -> Bool {
        return ValidatorService.isEmailValid(email) && ValidatorService.isPasswordValid(password)
    }
}
