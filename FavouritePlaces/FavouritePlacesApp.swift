//
//  FavouritePlacesApp.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 2/5/2022.
//

import SwiftUI

@main
// Struct used for mounting content view & use of persistence across the app.
struct FavouritePlacesApp: App {
    // Create a persistence controller.
    let persistenceController = PersistenceController()
 
    var body: some Scene {
        WindowGroup {
            // Render Content View
            ContentView()
                // Use of environment variable for path to managed object context and pass in persistence controller view context.
                // Needed for paths for add and delete functions. 
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
