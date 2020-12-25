//
//  DBManager.swift
//  hero_es
//
//  Created by Marivaldo Sena on 17/12/20.
//

import Foundation
import CoreData

struct DBManager {
    static var shared = DBManager()
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "hero_es")
        container.loadPersistentStores { storeDescription, error in
            if let nserror = error as NSError? {
                print("\(nserror) - \(nserror.userInfo)")
            }
        }
        return container
    }()
    
    mutating func getContainer() -> NSPersistentContainer {
        return persistentContainer
    }
}
