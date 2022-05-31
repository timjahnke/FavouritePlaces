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
    
    // Binding for automatically rendering SunData asynchronously.
    @State var data: SunriseSunset? = nil
    
    // Observe the Class Place from CoreData
    @ObservedObject var place: Place
//    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        // If Edit Mode is not active, create a list and render plain text and map with Class Place data
        if(editMode?.wrappedValue == .inactive) {
            List {
                // Create section using place title with black text, specified size in bold.
                Section(header:
                    Text(place.placeTitle)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                ) {}
                // Render system image from URL else render default image.
                place.getImage().aspectRatio(contentMode: .fit).foregroundColor(.green)
               
                // Check if details is an empty string. Will display default text if empty.
                HStack {
                    // Display place.placeDetails if string count is greater than 0.
                    if(place.placeDetails.count > 0) {
                        Text(place.placeDetails)
                    } else {
                        // Default Text
                        Text("Details: ")
                    }
                }
                
                // Display Navigation Link to MapView Page with a small map and text as a label.
                NavigationLink(destination: MapView(viewModel: MapViewModel(place: place))){
                    // Vertical stack of text along with a small map that is the same as the navigation destination's map.
                    HStack {
                        Map(coordinateRegion: $place.region).aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                        Spacer()
                        Text("Map of \(place.placeTitle)")
                    }
                }
                
                //Redraws automatically instead of on button click using asynchronous call.
                // Checks if data state is nil.
                // Sunrise / Sunset display
                VStack{
                    Button("Look up sunrise and sunset") {
                        // Synchronous version to trigger on Button Click.
                        // place.getSunDataAndDownload()
                        // Create a task to handle Asynchronous function call.
                    }.task {
                        // If asynchronous function has not been called, data will be nil.
                        if data == nil {
                            data = await place.download()
                        }
                    }
                    // Horizontal layout for Sunrise Data.
                    HStack {
                        // System image of Sunrise.
                        Image(systemName: "sunrise")
                        // Show heading & sunrise data.
                        Text("Sunrise: ")
                        if let data = data {
                            /// Accessing sunrise data through struct function
                            Text(data.sunrise)
                        // Else show progress wheel
                        } else {
                            ProgressView()
                        }
                    }
                    // Horizontal layout for Sunset Data.
                    HStack {
                        // System image of Sunset.
                        Image(systemName: "sunset")
                        // Show heading & sunset data.
                        Text("Sunset: ")
                        if let data = data {
                            /// Accessing sunset data through struct function
                            Text(data.sunset)
                        // Else show progress wheel
                        } else {
                            ProgressView()
                        }
                    }
                }.padding()
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
