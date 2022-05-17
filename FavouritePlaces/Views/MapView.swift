//
//  MapView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 14/5/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    
    // Stop the view from redrawing until movement has finished
    //.onDrag
    // look at map view documentation for interaction method
    
    // while dragged, don't touch placed
    // when finished touch place
    
    // similar to on commit. Only after finished dragging commit. 
    
    var body: some View {
        Text("Map of \(place.placeTitle)")
            .foregroundColor(.black)
            .font(.system(size: 30))
            .fontWeight(.bold)
        if(editMode?.wrappedValue == .inactive) {
            VStack {
                // Create region from ViewModel region. Also enable interactions like zoom in , drag to pan or both.
                // These include: .pan, .zoom or .all.
                Map(coordinateRegion: $place.region, interactionModes: .pan)
//                .onChange(of: place.region) { newValue in
//                    print("after drag")
//                }
//                
                HStack {
                    Text("Lat: ")
                    Text("\(place.placeLatitude)")
                }
                HStack {
                    Text("Lon: ")
                    Text("\(place.placeLongitude)")
                }
            }
            .toolbar {
                ToolbarItem(placement:
                .navigationBarTrailing) {
                   EditButton()
                }
            }
        }
        if(editMode?.wrappedValue == .active) {
            VStack {
                Map(coordinateRegion: $place.region)
                HStack {
                    Text("Lat: ")
                    TextField("Enter Latitude", value: $place.placeLatitude, formatter: place.formatter) {
                        // On commit
                        place.save()
                    }
                }
                HStack {
                    Text("Lon: ")
                    TextField("Enter Longitude", value: $place.placeLongitude, formatter: place.formatter) {
                        // On commit
                        place.save()
                    }
                }
            }
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
