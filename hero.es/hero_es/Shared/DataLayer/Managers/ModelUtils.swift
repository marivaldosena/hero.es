//
//  ModelUtils.swift
//  hero_es
//
//  Created by Marivaldo Sena on 03/01/21.
//

import Foundation

struct ModelUtils {
    static func getId(resourceURI: String) -> Int {
        var id = 0
        
        do {
            let tokens = resourceURI.split(separator: "/")
            id = Int(String(tokens[tokens.count - 1])) ?? 0
        } catch {
            print(error.localizedDescription)
        }
        
        return id
    }
}
