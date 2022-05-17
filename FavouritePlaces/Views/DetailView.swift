//
//  DetailView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 3/5/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    // Environmental variables for saving to view context and edit mode.
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.editMode) var editMode
    
    // Observe the Class \Place from CoreData
    @ObservedObject var place: Place
    
    var body: some View {
        // If Edit Mode is not active, create a list and render plain text with Class Place data
        if(editMode?.wrappedValue == .inactive) {
            List {
//              Create section with place title
                Section(header:
                    Text(place.placeTitle)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                ) {}
                // If place url starts with https:// and ends with .jpg or .png
                // Else render system image default. Default string is "".
                place.getImage().aspectRatio(contentMode: .fit).foregroundColor(.green)
               
                // Check if details is an empty string. Will display default text if empty.
                HStack {
                    if(place.placeDetails.count > 0) {
                        Text(place.placeDetails)
                    } else {
                        Text("Details: ")
                    }
                }
                
                // Display Navigation Link to MapView Page
                NavigationLink(destination: MapView(place: place)){
                    HStack {
                       
                        Map(coordinateRegion: $place.imageRegion).aspectRatio(contentMode: .fit)
                        Text("Map of \(place.placeTitle)")
                        Spacer()
                       
                    }
                }
               
                
//                // Display latitude and longitude together vertically in list row
//                VStack {
//                    // Create a row displaying inline heading and latitude.
//                    HStack{
//                        Text("Latitude:")
//                        Text(place.placeLatitude)
//                    }
//                    // Create a row displaying inline heading and longitude.
//                    HStack{
//                        Text("Longitude:")
//                        Text(place.placeLongitude)
//                    }
//                }
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
                HStack {
                    Text("Title: ").bold()
                    TextField("Edit title", text: $place.placeTitle, onCommit: {
                        // On commit save with ViewModel else throw error.
                        place.save()
                    })
                }
                // Create a vertical layout to display text inline with textfield.
                VStack {
                    Text("Image URL").bold()
                    TextField("Edit image URL", text: $place.placeUrl, onCommit: {
                        // On commit save with ViewModel else throw error.
                        place.save()
                    })
                }
                // Create vertical layout to display text and textfield for place details.
                VStack{
                    padding(2)
                    Text("Enter Place Detail Below:").bold()
                    TextField("Edit place details", text: $place.placeDetails, onCommit: {
                        // On commit save with ViewModel else throw error.
                        place.save()
                    })
                }
                // Create a horizontal layout to display text inline with textfield.
//                HStack{
//                    Text("Latitude: ").bold()
//                    TextField("Edit place latitude", text: $place.placeLatitude, onCommit: {
//                        // On commit save with ViewModel else throw error.
//                        place.save()
//                    })
//                }
                // Create a horizontal layout to display text inline with textfield.
//                HStack {
//                    Text("Longitude: ").bold()
//                    TextField("Edit place longitude", text: $place.placeLongitude, onCommit: {
//                        // On commit save with ViewModel else throw error.
//                        place.save()
//                    })
//                }
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
