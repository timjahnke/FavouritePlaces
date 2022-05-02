//
//  FavouritePlacesApp.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 2/5/2022.
//

import SwiftUI

@main
struct FavouritePlacesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
