//
//  Persistence.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 2/5/2022.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newPlace = Place(context: viewContext)
            // Set initial empty string values for newPlace attributes. Setting UUID() and Date() typing for respective attributes.
            newPlace.id = UUID()
            newPlace.timestamp = Date()
            newPlace.title = "" 
            newPlace.details = ""
            newPlace.latitude = ""
            newPlace.longitude = ""
            newPlace.url = ""
        }
        do {
            // Attempt to save to persistence controller's view context container.
            try viewContext.save()
        } catch {
            // Otherwise fatalError() causes the application to generate a crash log and terminate. For development purposes.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FavouritePlaces")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // fatalError() causes the application to generate a crash log and terminate. For development purposes.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
