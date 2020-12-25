//
//  ThumbnailModel.swift
//  hero.es
//
//  Created by Glayce Kelly on 27/10/20.
//

import Foundation

// MARK: - ThumbnailModel: Codable
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

// MARK: - ThumbnailModel
extension ThumbnailModel {
    static func from(string thumbnailUrl: String) -> ThumbnailModel {
        let dotIndex = thumbnailUrl.lastIndex(of: ".") ?? thumbnailUrl.endIndex
        let path = thumbnailUrl[..<dotIndex]
        let ext = thumbnailUrl[thumbnailUrl.index(after: dotIndex)..<thumbnailUrl.endIndex]
        
        return ThumbnailModel(path: String(path), ext: String(ext))
    }
}
