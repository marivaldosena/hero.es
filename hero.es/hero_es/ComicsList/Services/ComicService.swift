//
//  ComicService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 01/01/21.
//

import Foundation

typealias ComicServiceFinishHandlerType = (_ comics: [ComicModel]?, _ error: Error?) -> Void

protocol ComicServiceProtocol {
    func loadAllItems(completion: @escaping ComicServiceFinishHandlerType)
}

struct ComicService: ComicServiceProtocol {
    static var shared = ComicService()
    
    private init() {}
    
    private func requestComics(completion: @escaping ComicServiceFinishHandlerType) {
        guard let path = Bundle.main.path(forResource: "comics-list", ofType: "json") else { return }
        guard let json = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
        let modelsArray = ComicParser.from(json: json)
        completion(modelsArray, nil)
    }
    
    func loadAllItems(completion: @escaping ComicServiceFinishHandlerType) {
        self.requestComics { (comics, error) in
            completion(comics, error)
        }
    }
}
