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
    let persistenceController = PersistenceController.shared
 

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Use of environment variable for path to managed object context and pass in persistence controller view context. 
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
