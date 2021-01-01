//
//  ComicService.swift
//  hero_es
//
//  Created by Marivaldo Sena on 01/01/21.
//

import Foundation

typealias ComicServiceFinishHandlerType = (_ comics: [ComicModel]?, _ error: Error?) -> Void

struct ComicService {
    static var shared = ComicService()
    
    private init() {}
    
    func requestComics(completion: @escaping ComicServiceFinishHandlerType) {
        guard let path = Bundle.main.path(forResource: "comics-list", ofType: "json") else { return }
        guard let json = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
        let modelsArray = ComicParser.from(json: json)
        completion(modelsArray, nil)
    }
}
