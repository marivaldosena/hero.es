//
//  ServiceHeroes.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation
import Alamofire

protocol ServicesHeroesProtocol {
    
    func requestHeroes(name: String, completion: @escaping(Result<BaseModel, Error>) -> Void)
    
}

struct ServicesHeroes: ServicesHeroesProtocol {
    func requestHeroes(name: String, completion: @escaping (Result<BaseModel, Error>) -> Void) {
        print("DEGUB: Request heroes!!")
    }
}
