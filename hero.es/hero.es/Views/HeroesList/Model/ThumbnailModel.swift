//
//  ThumbnailModel.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation

struct ThumbnailModel: Codable {
    let path: String
    let ext: String
    
    var url: String {
        return path + "." + ext
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
