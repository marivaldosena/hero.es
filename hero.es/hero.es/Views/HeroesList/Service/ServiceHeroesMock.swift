//
//  ServiceHeroesMock.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation

struct ServiceHeroesMock: ServicesHeroesProtocol {
    
    func requestHeroes(name: String, completion: @escaping (Result<BaseModel, Error>) -> Void) {
        print("DEBUG: Request heroes mock!!!")
        
        do {
            let path: String = Bundle.main.path(forResource: "characters", ofType: "json")!
            let jsonData: Data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let baseModel: BaseModel = try JSONDecoder().decode(BaseModel.self, from: jsonData)
            
            completion(Result.success(baseModel))
        } catch {
            completion(Result.failure(error))
        }
    }
}

class Utils {
    static func loadJson<T: Codable>(with json: String) -> T? {
        do {
            let path = Bundle(for: self).path(forResource: json, ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let models = try JSONDecoder().decode(T.self, from: data)
            return models
        } catch {
            return nil
        }
    }
}
