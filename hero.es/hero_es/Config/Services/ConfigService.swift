//
//  ConfigService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 13/01/21.
//

import Foundation

protocol ConfigServiceProtocol {
    func update(email: String, withPassword: String)
    func update(password: String, oldPassword: String)
    func update(email: String, password: String, oldPassword: String)
}

struct ConfigService: ConfigServiceProtocol {
    static var shared: ConfigServiceProtocol = ConfigService()
    func update(email: String, withPassword: String) {
        
    }
    
    func update(password: String, oldPassword: String) {
        
    }
    
    func update(email: String, password: String, oldPassword: String) {
        
    }
}
