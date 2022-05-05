//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 2/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        // Create a navigation view that uses the master view component.
        // Also add a navigation title and view style to remove console errors. 
        NavigationView {
            MasterView()
            .navigationTitle("Favourite Places")
        }
        .navigationViewStyle(.stack)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
