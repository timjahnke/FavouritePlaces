//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 2/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.id, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        NavigationView {
            MasterView()
            .navigationTitle("Favourite Places")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement:
                .navigationBarTrailing) {
                    Button {
                        addPlace()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    // To Add a new place to the list
    private func addPlace() {
        withAnimation {
            // Add to environment variable view context with initial values
            let newPlace = Place(context: viewContext)
            newPlace.title = "New Place"
            newPlace.details = "Add some details"
            newPlace.latitude = "0.0"
            newPlace.longitude = "0.0"
            newPlace.image = ""

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
