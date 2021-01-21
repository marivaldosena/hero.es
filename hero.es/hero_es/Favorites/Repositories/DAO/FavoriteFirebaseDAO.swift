//
//  FavoriteFirebaseDAO.swift
//  hero_es
//
//  Created by Marivaldo Sena on 18/01/21.
//

import Foundation
import Firebase

//var id: Int
//var itemType: ItemType
//var name: String
//var resourceURI: String
//var thumbnailString: String
//var description: String
//var userId: String

class FavoriteFirebaseDAO: FavoriteDAOProtocol {
    static var shared = FavoriteFirebaseDAO()
    private let db: Firestore = Firestore.firestore()
    private let favorites: CollectionReference
    private var modelsArray: [FavoriteModel] = []
    
    init() {
         favorites = db.collection("favorites")
    }
    
    // MARK: - Public Methods
    func save(_ model: FavoriteModel, userId: String) {
        
    }
    
    func find(term: String? = nil, userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        favorites
            .whereField("userId", isEqualTo: userId)
            .whereField("itemType", isEqualTo: itemType)
            .addSnapshotListener { (snapshot, error) in
            print("Listening documents")
            if let error = error {
                print(error.localizedDescription)
            }
            guard let documents = snapshot?.documents else { return }
            
            for document in documents {
                print("===== Beginning of Firebase =====")
                if let model = FavoriteParser.from(document) {
                    print("Got model!")
                    self.modelsArray.append(model)
                }
                print("===== End of Firebase =====")
            }
        }
        return modelsArray
    }
    
    func find(id: Int, userId: String, itemType: SearchItemType) -> FavoriteModel? {
        // TODO: Implement this
        return nil
    }
    
    func exists(id: Int, userId: String, itemType: SearchItemType) -> Bool {
        // TODO: Implement this
        var result = false
        
        favorites
            .whereField("id", isEqualTo: id)
            .whereField("userId", isEqualTo: userId)
            .whereField("itemType", isEqualTo: itemType)
            .limit(to: 1)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let snapshot = snapshot else { return }
                print(snapshot.documents)
                result = true
        }
        
        return result
    }
    
    func delete(id: Int, userId: String, itemType: SearchItemType) {
        // TODO: Implement this
    }
    
    func isFavorite(id: Int, userId: String, itemType: SearchItemType) -> Bool {
        // TODO: Implement this
        return false
    }
}
