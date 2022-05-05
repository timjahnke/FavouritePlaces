//
//  DetailView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 3/5/2022.
//

import SwiftUI

struct DetailView: View {
    // Environmental variables for saving to view context and edit mode.
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.editMode) var editMode
    
    // Observe the Class \Place from CoreData
    @ObservedObject var place: Place
    var imageURL: String = "https://www.planetware.com/photos-large/AUS/australia-brisbane-city-2.jpg"
    
    var body: some View {
        // If Edit Mode is active, create a list and render plain text with Class Place data
        if(editMode?.wrappedValue == .inactive) {
            List {
                Section(header:
                    Text(place.placeTitle)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .fontWeight(.bold)) {}
                // Default string is "". If string length is greater than 0, render image
                // Else render system image default.
                if(place.placeImage.count > 0) {
                        ImageView(place: place)
                    } else {
                        Image(systemName: "location.square").foregroundColor(.green)
                    }
                    Text(place.placeDetails)
                    VStack {
                        HStack{
                            Text("Latitude:")
                            Text(place.placeLatitude)
                        }
                        
                        HStack{
                            Text("Longitude:")
                            Text(place.placeLongitude)
                        }
                    }
                }
            // Create a toolbar edit button trailing.
            .toolbar {
                ToolbarItem(placement:
                .navigationBarTrailing) {
                   EditButton()
                }
            }
        }
        // If Edit Mode Is Active, create a list and render editable Text fields
        // Saves results to context to update Class Place 
        else if(editMode?.wrappedValue == .active) {
            List {
                TextField("Edit title", text: $place.placeTitle, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
                TextField("Edit place details", text: $place.placeDetails, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
                TextField("Edit image URL", text: $place.placeImage, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
                TextField("Edit place latitude", text: $place.placeLatitude, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
                TextField("Edit place longitude", text: $place.placeLongitude, onCommit: {
                    // Attempt save else throw fatalError
                    do { try viewContext.save()}
                    catch{ fatalError()}
                })
            }
            // Create a toolbar edit button trailing.
            .toolbar {
                ToolbarItem(placement:
                .navigationBarTrailing) {
                   EditButton()
                }
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
