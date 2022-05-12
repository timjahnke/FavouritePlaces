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
    
    // Fetch request from Database using class entity. Sorts by timestamp attribute ascending.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.timestamp, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        // Create a list and iterate through each fetched place.
        List {
            ForEach(places) { place in
                // Navigation link that routes to the details of each individual place.
                NavigationLink(destination: DetailView(place: place)) {
                    // Each list item is laid out horizontally with an image followed by the place title.
                    HStack {
                        // If place url starts with https:// and ends with .jpg or .png render Master Image View. Has smaller image size.
                        // Else render system image default. Default string is "".
                        place.getImage().aspectRatio(contentMode: .fit).foregroundColor(.green).frame(width: 40, height: 40)
                        // Text for each list item. Default valueis "New Place" when created using addPlace().
                        Text(place.placeTitle)
                    }
                }
            }
            // Delete function below for deleting a list item using index set.
            .onDelete(perform: deletePlaces)
        }
        // Set a toolbar with a leading plus button and trailing edit button.
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
            newPlace.timestamp = Date()
            newPlace.title = "New Place"
            newPlace.details = ""
            newPlace.latitude = "0.0"
            newPlace.longitude = "0.0"
            newPlace.url = ""
            // Attempt to save to view context using function inside ViewModel otherwise throw an error
            newPlace.save()
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
                // fatalError() causes the application to generate a crash log and terminate. For development purposes.
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
