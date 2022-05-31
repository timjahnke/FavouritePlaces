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
            .onDelete(perform: deletePlaces)
        }
        // Set a toolbar with a leading plus button and trailing edit button.
        .toolbar {
            ToolbarItem(placement:
            // Plus Button in Leading Position
            .navigationBarLeading) {
                Button {
                  addPlace()
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
    
    
     // To Add a new place to the list
     ///      Parameters: None
     ///      Return: None
     private func addPlace() {
         withAnimation {
             // Add to environment variable view context with initial values
             // Stores values in CoreData entity Place.
             let newPlace = Place(context: viewContext)
             // Initialise default values to store in CoreData
             newPlace.id = UUID()
             newPlace.timestamp = Date()
             newPlace.title = "New Place"
             newPlace.details = ""
             newPlace.latitude = 0.0
             newPlace.longitude = 0.0
             newPlace.url = ""
             // Attempt to save to view context using function inside ViewModel otherwise throw an error
             newPlace.save()
         }
     }
  
     // Delete places from the list.
     ///     Parameters: Index Set
     ///     return: None, Can throw a FatalError.
     func deletePlaces(offsets: IndexSet) {
         
         withAnimation {
             // Return an array of retrieved places using the index set.
             // For each element retrieved using the index set, Delete each NSObject from array at that index.
             offsets.map { places[$0] }.forEach(viewContext.delete)
             do {
                 // Attempt to save to view context otherwise throw an error
                 try viewContext.save()
             } catch {
                 // fatalError() causes the application to generate a crash log and terminate. For development purposes.
                 let nsError = error as NSError
                 // Return the error as a string with user information.
                 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             }
         }
     }
}
