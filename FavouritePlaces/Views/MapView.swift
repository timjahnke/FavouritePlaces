//
//  MapView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 14/5/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    // Environment variable for editMode
    @Environment(\.editMode) var editMode
    // State binding for allowing better control of redrawing map on updated values such as coordinates.
    @State var region: MKCoordinateRegion
    // Observe Class & Extension Place for published changes.
    @ObservedObject var place: Place
    
    // Create a view with a title and conditional render based on editMode state.
    var body: some View {
        // Title with black font of specified size in bold.
        Text("Map of \(place.placeTitle)")
            .foregroundColor(.black)
            .font(.system(size: 30))
            .fontWeight(.bold)
        // When edit mode not active.
        if(editMode?.wrappedValue == .inactive) {
            // Start a vertical layout
            VStack {
                // Create region from ViewModel region. Also enable interaction modes like zoom in, drag to pan or all. Currently using pan.
                // Also get map to fit to screen.
                Map(coordinateRegion: $region, interactionModes: .pan).aspectRatio(contentMode: .fit)
                    // When values change in the map such as when dragged/panned during interaction,
                    .onChange(of: region) { newValue in
                        // Set computed values inside Class Extension of Place to region's current coordinates.
                        place.placeLatitude = region.center.latitude
                        place.placeLongitude = region.center.longitude
                        // Save to viewContext through Class Extension Place.
                        place.save()
                    }
                // Below the Map
                // Create a horizontal layout with a label and the current latitude of the region.
                HStack {
                    Text("Lat: ")
                    Text("\(place.placeLatitude)").bold()
                }
                
                // Create a horizontal layout with a label and the current longitude of the region.
                HStack {
                    Text("Lon: ")
                    Text("\(place.placeLongitude)").bold()
                }
            }
            // Create a navigation bar with an edit button trailing.
            .toolbar {
                ToolbarItem(placement:
                .navigationBarTrailing) {
                   EditButton()
                }
            }
        }
        // Fix this. Does not redraw on change with text field
        // When edit mode is active.
        if(editMode?.wrappedValue == .active) {
            // Start a vertical layout
            VStack {
                // Horizontal layout for displaying coordinates from a name.
                HStack {
                    TextField("Enter a name to find coordinates for", text: $place.placeTitle) {
                        place.lookupCoordinates(for: place.placeTitle)
                    }
                }
                
                // Create region from ViewModel region. Also enable interaction modes like zoom in, drag to pan or all. Currently using pan.
                // Also get map to fit to screen.
                Map(coordinateRegion: $region, interactionModes: .zoom).aspectRatio(contentMode: .fit)
                    // When values change in the map such as when dragged/panned during interaction,
                    .onChange(of: region) { newValue in
                        // Set computed values inside Class Extension of Place to region's current coordinates.
                        place.placeLatitude = region.center.latitude
                        place.placeLongitude = region.center.longitude
                        // Save to viewContext through Class Extension Place.
                        place.save()
                    }
                // Below the Map
                // Create a horizontal layout with a label and the current latitude of the region.
                HStack {
                    Text("Lat: ")
                    TextField("Enter Latitude", value: $region.center.latitude, formatter: place.formatter)
                }
                
                // Create a horizontal layout with a label and the current longitude of the region.
                HStack {
                    Text("Lon: ")
                    TextField("Enter Longitude", value: $region.center.longitude, formatter: place.formatter)
                }
            }
            // Create a navigation bar with an edit button trailing.
            .toolbar {
                ToolbarItem(placement:
                .navigationBarTrailing) {
                   EditButton()
                }
            }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
