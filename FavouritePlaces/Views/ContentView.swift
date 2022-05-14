//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 2/5/2022.
//

import SwiftUI
import CoreData
import MapKit

// Main view for displaying content. Home Screen
struct ContentView: View {
    var body: some View {
        // Create a navigation view that uses the master view component.
        NavigationView {
            MasterView()
            // Navigation title for the Home Screen
            .navigationTitle("Favourite Places")
        }
        // Add view style to remove console errors.
        .navigationViewStyle(.stack)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
