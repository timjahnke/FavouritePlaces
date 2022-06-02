//
//  MasterView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 3/5/2022.
//

import SwiftUI
import MapKit

struct MasterView: View {
    
//  Environmental variable for using functions for adding/ deleting from context.
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
                        // Render image from Class Extension Place. If Default string of "", render default image.
                        // Image is scaled to fit and frame set to fixed size.
                        place.getImage().aspectRatio(contentMode: .fit).foregroundColor(.green).frame(width: 40, height: 40)
                        // Text for each list item. Default valueis "New Place" when created using addPlace().
                        Text(place.placeTitle)
                    }
                }
            }
            // Delete function below for deleting a list item using index set.
            .onDelete { indexSet in
                Place.delete(indexSet.map { places[$0] }, from: viewContext)
            }
        }
        // Set a toolbar with a leading plus button and trailing edit button.
        .toolbar {
            ToolbarItem(placement:
            // Plus Button in Leading Position
            .navigationBarLeading) {
                Button {
                  _ = Place(addingInto: viewContext)
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
            // Edit Button in trailing position.
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}
