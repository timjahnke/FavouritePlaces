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
    
    var body: some View {
        // If Edit Mode is active, create a list and render plain text with Class Place data
        if(editMode?.wrappedValue == .inactive) {
            List {
                // Create section with place title
                Section(header:
                    Text(place.placeTitle)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .fontWeight(.bold)) {}
                // If place url starts with https:// and ends with .jpg or .png
                if(
                    (place.placeUrl.hasPrefix("https://") && place.placeUrl.hasSuffix(".jpg")) ||
                    (place.placeUrl.hasPrefix("https://") && place.placeUrl.hasSuffix(".png"))
                    )
                    {
                        // render Detail Image View. Has larger image size.
                        Detail_ImageView(place: place)
                    // Else render system image default. Default string is "".
                    } else {
                        Image(systemName: "location.square").foregroundColor(.green)
                    }
                    // Check if details is an empty string. Will display default text if empty.
                    HStack {
                        if(place.placeDetails.count > 0) {
                            Text(place.placeDetails)
                        } else {
                            Text("Details: ")
                        }
                    }
                // Display latitude and longitude together vertically in list row
                    VStack {
                        // Create a row displaying inline heading and latitude.
                        HStack{
                            Text("Latitude:")
                            Text(place.placeLatitude)
                        }
                        // Create a row displaying inline heading and longitude.
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
                // Create a horizontal layout to display title and title textfield.
                // On commit save to context else throw error.
                HStack {
                    Text("Title: ").bold()
                    TextField("Edit title", text: $place.placeTitle, onCommit: {
                        // Attempt save else throw fatalError
                        do { try viewContext.save()}
                        catch{ fatalError()}
                    })
                }
               
                // Create a vertical layout to display text inline with textfield.
                // On commit save to context else throw error.
                VStack {
                    Text("Image URL").bold()
                    TextField("Edit image URL", text: $place.placeUrl, onCommit: {
                        // Attempt save else throw fatalError
                        do { try viewContext.save()}
                        catch{ fatalError()}
                    })
                }
                
                // Create vertical layout to display text and textfield for place details.
                // On commit save to context else throw error.
                VStack{
                    padding(2)
                    Text("Enter Place Detail Below:").bold()
                    TextField("Edit place details", text: $place.placeDetails, onCommit: {
                        // Attempt save else throw fatalError
                        do { try viewContext.save()}
                        catch{ fatalError()}
                    })
                }
                // Create a horizontal layout to display text inline with textfield.
                // On commit save to context else throw error.
                HStack{
                    Text("Latitude: ").bold()
                    TextField("Edit place latitude", text: $place.placeLatitude, onCommit: {
                        // Attempt save else throw fatalError
                        do { try viewContext.save()}
                        catch{ fatalError()}
                    })
                }
             
                // Create a horizontal layout to display text inline with textfield.
                // On commit save to context else throw error.
                HStack {
                    Text("Longitude: ").bold()
                    TextField("Edit place longitude", text: $place.placeLongitude, onCommit: {
                        // Attempt save else throw fatalError
                        do { try viewContext.save()}
                        catch{ fatalError()}
                    })
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
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
