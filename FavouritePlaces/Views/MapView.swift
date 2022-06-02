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
    
    // Observed Class MapViewModel for published changes related to map region. Class Extension Place referenced within MapViewModel. 
    @ObservedObject var viewModel: MapViewModel
    
    // Create a view with a title and conditional render based on editMode state.
    var body: some View {
        VStack {
            // Title with black font of specified size in bold.
            Text("Map of \(viewModel.title)")
                .foregroundColor(.black)
                .font(.system(size: 30))
                .fontWeight(.bold)
            // When edit mode not active.
            if(editMode?.wrappedValue == .inactive) {
                // Start a vertical layout
                VStack {
                    // Create region from ViewModel region. Also enable interaction modes like zoom in, drag to pan or all. Currently using pan.
                    // Also get map to fit to screen.
                    Map(coordinateRegion: $viewModel.region, interactionModes: .pan).aspectRatio(contentMode: .fit)
                        // When values change in the map such as when dragged/panned during interaction,
                    
                        // When View Model publisher receives changes
                        .onReceive(viewModel.publisher) { newValue in
                            // Set computed values inside Extension Place to View Model region's current coordinates.
                            viewModel.place.placeLatitude = viewModel.region.center.latitude
                            viewModel.place.placeLongitude = viewModel.region.center.longitude
                            // Save to viewContext through reference to Extension Place.
                            viewModel.place.save()
                        }
                    // Below the Map
                    // Create a horizontal layout with a label and the current latitude of the region.
                    HStack {
                        Text("Lat: ")
                        Text("\(viewModel.place.placeLatitude)").bold()
                    }
                    
                    // Create a horizontal layout with a label and the current longitude of the region.
                    HStack {
                        Text("Lon: ")
                        Text("\(viewModel.place.placeLongitude)").bold()
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
            // When edit mode is active.
            if(editMode?.wrappedValue == .active) {
                // Start a vertical layout
                VStack {
                    // Horizontal layout for displaying coordinates from a name.
                    HStack {
                        // Create system image of magnifying glass.
                        Image(systemName: "text.magnifyingglass")
                        // Create heading, space and text field.
                        Text("Place: ")
                        Spacer()
                        TextField("Find coordinates for place", text: $viewModel.title) {
                            // On commit, use geocoding function to find coordinates from Extension Place computed title.
                            // Stores latitude/ longitude in Extension Place CoreData.
                            viewModel.lookupCoordinates(for: viewModel.place.placeTitle)
                        }
                    }
                    
                    // Create region from ViewModel region. Also enable interaction modes like zoom in, drag to pan or all. Currently using pan.
                    // Also get map to fit to screen.
                    Map(coordinateRegion: $viewModel.region, interactionModes: .zoom).aspectRatio(contentMode: .fit)
                        // When values change in the map such as when dragged/panned during interaction,
                        .onChange(of: viewModel.region) { newValue in
                            // Set computed values inside Class Extension of Place to region's current coordinates.
                            viewModel.place.placeLatitude = viewModel.region.center.latitude
                            viewModel.place.placeLongitude = viewModel.region.center.longitude
                            // Save to viewContext through Class Extension Place.
                            viewModel.place.save()
                        }
                    // Below the Map
                    // Create a horizontal layout with a label and the current latitude of the region.
                    HStack {
                        Text("Lat: ")
                        // $region.center.latitude
                        TextField("Enter Latitude", value: $viewModel.latitude, formatter: viewModel.place.formatter)
                    }
                    
                    // Create a horizontal layout with a label and the current longitude of the region.
                    HStack {
                        Text("Lon: ")
                        // $region.center.longitude
                        TextField("Enter Longitude", value: $viewModel.longitude, formatter: viewModel.place.formatter)
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
            // On change of View, view model latitude stores new value.
        }.onChange(of: viewModel.latitude) {
            viewModel.region.center.latitude = $0
            // Also perform lookup name from location if latitude changes in MapView VStack.
            viewModel.lookupName(for: CLLocation(latitude:  viewModel.latitude, longitude: viewModel.longitude))
            
            // On change of View, view model longitude stores new value.
            // Also lookup name from location if longitude changes in MapView VStack.
        }.onChange(of: viewModel.longitude) {
            viewModel.region.center.longitude = $0
            viewModel.lookupName(for: CLLocation(latitude:  viewModel.latitude, longitude: viewModel.longitude))
        }
    }
}
