//
//  StringUtils.swift
//  hero.es
//
//  Created by Marivaldo Sena on 06/11/20.
//

import Foundation

extension String {
    var isEmailValid: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
}

extension Bool {
    func failure(onFailure: () -> Void) -> Bool {
        if self != true {
            onFailure()
            return false
        }
        return true
    }
}
