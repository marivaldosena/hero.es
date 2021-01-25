//
//  FavoriteFirebaseDAO.swift
//  hero_es
//
//  Created by Marivaldo Sena on 18/01/21.
//

import Foundation
import Firebase

class FavoriteFirebaseDAO: FavoriteDAOProtocol {
    static var shared = FavoriteFirebaseDAO()
    private let db: Firestore = Firestore.firestore()
    let coreDataDAO = FavoriteCoreDataDAO(container: DBManager.shared.getContainer())
    private var modelsArray: [FavoriteModel] = []
    
    // MARK: - Public Methods
    func save(_ model: FavoriteModel, userId: String) {
        if find(id: model.id, userId: userId, itemType: model.getSearchItemType()) == nil {
            saveInCoreData(userId: userId, [model])
            saveInFirebase(userId: userId, [model])
        } else {
            updateInFirebase(userId: userId, [model])
        }
    }
    
    func find(term: String? = nil, userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        loadItems(term: term, userId: userId, itemType: itemType, limit: limit, offset: offset) { (models, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let models = models else { return }
            self.modelsArray = models
        }
        
        self.modelsArray = coreDataDAO.find(term: term, userId: userId, itemType: itemType, limit: limit, offset: offset)
        return modelsArray
    }
    
    func find(id: Int, userId: String, itemType: SearchItemType) -> FavoriteModel? {
        findOneInFirebase(id: id, userId: userId) { (documents, error) in
            let models = self.getModelsArray(from: documents)
            
            if !self.exists(id: id, userId: userId, itemType: itemType) {
                self.saveInCoreData(userId: userId, models)
            }
        }
        
        return coreDataDAO.find(id: id, userId: userId, itemType: itemType)
    }
    
    func exists(id: Int, userId: String, itemType: SearchItemType) -> Bool {
        return coreDataDAO.exists(id: id, userId: userId, itemType: itemType)
    }
    
    func delete(id: Int, userId: String, itemType: SearchItemType) {
        // TODO: Implement this
    }
    
    func isFavorite(id: Int, userId: String, itemType: SearchItemType) -> Bool {
        return coreDataDAO.isFavorite(id: id, userId: userId, itemType: itemType)
    }
    
    // MARK: - Private Methods
    private func loadItems(term: String? = nil, userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0, completion: @escaping (_ array: [FavoriteModel]?, _ error: Error?) -> Void) {
        let favorites = db.collection("users")
            .document(userId)
            .collection("favorites")
            .whereField("itemType", in: itemType.getFirebaseItemTypeValues())
        
        favorites.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([], error)
            }
            
            let models = self.getModelsArray(from: snapshot?.documents)
            self.saveInCoreData(userId: userId, models)
            completion(models, error)
        }
    }
    
    private func saveInCoreData(userId: String, _ models: [FavoriteModel]) {
        for model in models {
            coreDataDAO.save(model, userId: userId)
        }
    }
    
    private func saveInFirebase(userId: String, _ models: [FavoriteModel]) {
        for model in models {
            getFavoriteFirebaseCollection(userId: userId)
                .addDocument(data: getDataDictionary(for: model)) { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
            }
        }
    }
    
    private func updateInFirebase(userId: String, _ models: [FavoriteModel]) {
        for model in models {
            findOneInFirebase(id: model.id, userId: userId) { (documents, error) in
                guard let documents = documents else { return }
                
                for document in documents {
                    document.setValuesForKeys(self.getDataDictionary(for: model))
                }
            }
        }
    }
    
    private func findOneInFirebase(id: Int, userId: String, itemType: SearchItemType = .all,
                                   completion: @escaping (_ document: [QueryDocumentSnapshot]?, _ error: Error?) -> Void) {
        db.collection("users")
        .document(userId)
        .collection("favorites")
        .whereField("id", isEqualTo: id)
        .whereField("itemType", isEqualTo: itemType.getFirebaseItemTypeValues())
        .limit(to: 1)
        .getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([], error)
            }
            
            if let documents = snapshot?.documents {
                completion(documents, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    private func getModelsArray(from documents: [QueryDocumentSnapshot]?) -> [FavoriteModel] {
        guard let documents = documents else { return [] }
        return FavoriteParser.from(documents)
    }
    
    private func getDataDictionary(for model: FavoriteModel) -> [String: Any] {
        let data: [String: Any] = [
            "id": model.id,
            "itemType": model.itemType.rawValue,
            "name": model.name,
            "description": model.description,
            "resourceURI": model.resourceURI,
            "thumbnail": model.thumbnailString,
        ]
        
        return data
    }
    
    private func getFavoriteFirebaseCollection(userId: String) -> CollectionReference {
        return db.collection("users").document(userId).collection("favorites")
    }
}
