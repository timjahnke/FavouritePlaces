//
//  MasterView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 3/5/2022.
//

import SwiftUI

struct MasterView: View {
    // Environmental variable for using functions for adding/ deleting from context.
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch request from Database using class entity.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.id, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        List {
            ForEach(places, id: \.self.id) { place in
                NavigationLink(destination: DetailView(place: place)) {
                    if(place.placeUrl.contains("https://www"))  {
                        HStack {
                            Master_ImageView(place: place)
                            Text(place.placeTitle)
                        }
                    }
                    else {
                        HStack {
                          Image(systemName: "location.square").foregroundColor(.green)
                          Text(place.placeTitle)
                      }
                    }
                }
            }
            .onDelete(perform: deletePlaces)
        }
        // Set a toolbar with a leading edit button and trailing plus button.
        .toolbar {
            ToolbarItem(placement:
            .navigationBarLeading) {
                Button {
                    addPlace()
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }

    // To Add a new place to the list
    private func addPlace() {
        withAnimation {
            // Add to environment variable view context with initial values
            let newPlace = Place(context: viewContext)
            newPlace.id = UUID()
            newPlace.title = "New Place"
            newPlace.details = ""
            newPlace.latitude = "0.0"
            newPlace.longitude = "0.0"
            newPlace.url = ""

            do {
                // Attempt to save to view context otherwise throw an error
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
 
    // Delete places from the list.
    private func deletePlaces(offsets: IndexSet) {
        withAnimation {
            // Return an array of retrieved places using the index set. Delete each NSObject from array.
            offsets.map { places[$0] }.forEach(viewContext.delete)

            do {
                // Attempt to save to view context otherwise throw an error
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

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
