//
//  Persistence.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 2/5/2022.
//

import CoreData
import MapKit

struct PersistenceController {
    // Create a container to access NSPersistence
    let container: NSPersistentContainer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FavouritePlaces")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // fatalError() causes the application to generate a crash log and terminate. For development purposes.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
