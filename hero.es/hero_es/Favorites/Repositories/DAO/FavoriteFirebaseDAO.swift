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
        let foundModel = find(id: model.id, userId: userId, itemType: model.getSearchItemType())
            
        if foundModel == nil {
            saveInCoreData(userId: userId, model)
            saveInFirebase(userId: userId, model)
        } else {
            updateInFirebase(userId: userId, model)
        }
    }
    
    func find(term: String? = nil, userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0) -> [FavoriteModel] {
        loadItems(term: term, userId: userId, itemType: itemType, limit: limit, offset: offset) { (models, error) in
            if let error = error {
                print("DEBUG: FavoriteFirebaseDAO.find - \(error.localizedDescription)")
            }
            guard let models = models else { return }
            self.modelsArray = models
            self.saveInCoreData(userId: userId, models)
        }
        
        self.modelsArray = coreDataDAO.find(term: term, userId: userId, itemType: itemType, limit: limit, offset: offset)
        return modelsArray
    }
    
    func find(id: Int, userId: String, itemType: SearchItemType = .all) -> FavoriteModel? {
        findOneInFirebase(id: id, userId: userId, itemType: itemType) { (documents, error) in
            if let error = error {
                print("DEBUG: FavoriteFirebaseDAO.find - \(error.localizedDescription)")
            }
            
            let models = self.getModelsArray(from: documents)
            
            if !self.exists(id: id, userId: userId, itemType: itemType) {
                self.saveInCoreData(userId: userId, models)
            }
        }
        
        return coreDataDAO.find(id: id, userId: userId, itemType: itemType)
    }
    
    func exists(id: Int, userId: String, itemType: SearchItemType = .all) -> Bool {
        return coreDataDAO.exists(id: id, userId: userId, itemType: itemType)
    }
    
    func delete(_ model: FavoriteModel, userId: String) {
        delete(id: model.id, userId: userId, itemType: model.itemType.getSearchItemType())
    }
    
    func delete(id: Int, userId: String, itemType: SearchItemType = .all) {
        guard let foundModel = find(id: id, userId: userId, itemType: itemType) else { return }
        
        deleteInFirebase(userId: userId, foundModel)
        deleteInCoreData(userId: userId, foundModel)
    }
    
    func isFavorite(id: Int, userId: String, itemType: SearchItemType = .all) -> Bool {
        return coreDataDAO.isFavorite(id: id, userId: userId, itemType: itemType)
    }
    
    // MARK: - Private Methods
    private func loadItems(term: String? = nil, userId: String, itemType: SearchItemType = .all, limit: Int = 0, offset: Int = 0,
                           completion: @escaping (_ array: [FavoriteModel]?, _ error: Error?) -> Void) {
        let favorites = getFavoriteFirebaseCollection(userId: userId)
        favorites.whereField("itemType", in: itemType.getFirebaseItemTypeValues())
        
        favorites.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("DEBUG: FavoriteFirebaseDAO.loadItems - \(error.localizedDescription)")
                completion([], error)
            }
            
            let models = self.getModelsArray(from: snapshot?.documents)
            completion(models, error)
        }
    }
    
    private func saveInCoreData(userId: String, _ models: [FavoriteModel]) {
        for model in models {
            saveInCoreData(userId: userId, model)
        }
    }
    
    private func saveInCoreData(userId: String, _ model: FavoriteModel) {
        coreDataDAO.save(model, userId: userId)
    }
    
    private func saveInFirebase(userId: String, _ models: [FavoriteModel]) {
        for model in models {
            saveInFirebase(userId: userId, model)
        }
    }
    
    private func saveInFirebase(userId: String, _ model: FavoriteModel) {
        findOneInFirebase(id: model.id, userId: userId, itemType: model.itemType.getSearchItemType()) { (snapshot, error) in
            if let error = error {
                print("DEBUG: FavoriteFirebaseDAO.saveInFirebase - \(error.localizedDescription)")
            }
            
            if let documents = snapshot, documents.count > 0 {
                let favorites = self.getFavoriteFirebaseCollection(userId: userId)
                favorites.document(documents[0].documentID).setData(self.getDataDictionary(for: model))
            } else {
                let favorites = self.getFavoriteFirebaseCollection(userId: userId)
                
                favorites.addDocument(data: self.getDataDictionary(for: model)) { (error) in
                    if let error = error {
                        print("DEBUG: FavoriteFirebaseDAO.saveInFirebase - \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func updateInFirebase(userId: String, _ models: [FavoriteModel]) {
        for model in models {
            updateInFirebase(userId: userId, model)
        }
    }
    
    private func updateInFirebase(userId: String, _ model: FavoriteModel) {
        findOneInFirebase(id: model.id, userId: userId, itemType: model.itemType.getSearchItemType()) { (documents, error) in
            if let error = error {
                print("DEBUG: FavoriteFirebaseDAO.updateInFirebase - \(error.localizedDescription)")
            }
            
            guard let documents = documents else { return }
            
            for document in documents {
                let favorites = self.getFavoriteFirebaseCollection(userId: userId)
                favorites.document(document.documentID).updateData(self.getDataDictionary(for: model)) { (error) in
                    if let error = error {
                        print("DEBUG: FavoriteFirebaseDAO.updateInFirebase - \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func deleteInFirebase(userId: String, _ model: FavoriteModel) {
        findOneInFirebase(id: model.id, userId: userId, itemType: model.itemType.getSearchItemType()) { (documents, error) in
            if let error = error {
                print("DEBUG: FavoriteFirebaseDAO.deleteInFirebase - \(error.localizedDescription)")
            }

            for document in documents ?? [] {
                self.getFavoriteFirebaseCollection(userId: userId).document(document.documentID).delete()
            }
        }
    }
    
    private func deleteInCoreData(userId: String, _ models: [FavoriteModel]) {
        for model in models {
            deleteInCoreData(userId: userId, model)
        }
    }
    
    private func deleteInCoreData(userId: String, _ model: FavoriteModel) {
        coreDataDAO.delete(id: model.id, userId: userId, itemType: model.itemType.getSearchItemType())
    }
    
    private func findOneInFirebase(id: Int, userId: String, itemType: SearchItemType = .all,
                                   completion: @escaping (_ document: [QueryDocumentSnapshot]?, _ error: Error?) -> Void) {
        
        let favorites = getFavoriteFirebaseCollection(userId: userId)
        
        favorites
            .whereField("id", isEqualTo: id)
            .whereField("itemType", in: itemType.getFirebaseItemTypeValues())
            .limit(to: 1)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("DEBUG: FavoriteFirebaseDAO.findOneInFirebase - \(error.localizedDescription)")
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
