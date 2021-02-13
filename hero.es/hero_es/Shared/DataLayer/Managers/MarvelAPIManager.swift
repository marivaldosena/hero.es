//
//  MarvelAPIManager.swift
//  hero_es
//
//  Created by Marivaldo Sena on 07/02/21.
//

import Foundation
import CommonCrypto

extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}

protocol MarvelAPIManagerProtocol {
    func buildUrl(url: String, params: Dictionary<String, Any>) -> String
    func buildUrl(url: String, params: Dictionary<String, Any>) -> URL?
}

struct MarvelAPIManager: MarvelAPIManagerProtocol {
    private let baseURL: URL
    private let privateKey: String
    private let apiKey: String
    
    static let shared: MarvelAPIManagerProtocol = MarvelAPIManager(
        baseURL: URL(string: "https://gateway.marvel.com:443")!,
        privateKey: ProcessInfo.processInfo.environment["MARVEL_PRIVATE_KEY"] ?? "",
        apiKey: ProcessInfo.processInfo.environment["MARVEL_PUBLIC_KEY"] ?? ""
        
    )
    
    init(baseURL: URL, privateKey: String, apiKey: String) {
        self.baseURL = baseURL
        self.privateKey = privateKey
        self.apiKey = apiKey
    }
    
    func buildUrl(url: String, params: Dictionary<String, Any> = [:]) -> String {
        var newUrlString: String = "\(self.baseURL)\(url)"
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(privateKey)\(apiKey)".md5
        
        
        if !params.isEmpty {
            newUrlString.append("?")
            
            for entry in params {
                newUrlString.append("\(entry.key)=\(entry.value)")
            }
            
            return "\(newUrlString)&ts=\(timestamp)&apikey=\(apiKey)&hash=\(hash)"
        }
        
        return "\(newUrlString)?ts=\(timestamp)&apikey=\(apiKey)&hash=\(hash)"
    }
    
    func buildUrl(url: String, params: Dictionary<String, Any> = [:]) -> URL? {
        guard let newUrl = URL(string: buildUrl(url: url, params: params)) else { return nil }
        return newUrl
    }
}
