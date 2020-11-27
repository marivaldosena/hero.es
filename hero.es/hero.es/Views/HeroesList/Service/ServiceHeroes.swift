//
//  ServiceHeroes.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation

protocol ServicesHeroesProtocol {
    
    func requestHeroes(name: String, completion: @escaping (Swift.Result<[HeroModel], Error>) -> Void)
    
}

struct ServicesHeroes: ServicesHeroesProtocol {
    func requestHeroes(name: String, completion: @escaping (Swift.Result<[HeroModel], Error>) -> Void) {
        print("DEGUB: Request heroes!!")
    }
}
