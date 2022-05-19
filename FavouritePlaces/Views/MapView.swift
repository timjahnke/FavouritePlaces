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
    @State var region: MKCoordinateRegion
    @ObservedObject var place: Place
//    var location: Location
    
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
                Map(coordinateRegion: $region, interactionModes: .pan).aspectRatio(contentMode: .fit)
                    .onChange(of: region) { newValue in
                        print("after drag")
    //                    print(region.center.latitude)
    //                    print(region.center.longitude)
                        place.placeLatitude = region.center.latitude
                        place.placeLongitude = region.center.longitude
                        place.save()
                        print("lat",place.placeLatitude, "lon", place.placeLongitude)
                    }

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
                Map(coordinateRegion: $region, interactionModes: .zoom).aspectRatio(contentMode: .fit)
                    .onChange(of: region) { newValue in
                    print("after drag")
//                    print(region.center.latitude)
//                    print(region.center.longitude)
                    place.placeLatitude = region.center.latitude
                    place.placeLongitude = region.center.longitude
                    place.save()
                    print("lat",place.placeLatitude, "lon", place.placeLongitude)
                    }
                HStack {
                    Text("Lat: ")
                    TextField("Enter Latitude", value: $region.center.latitude, formatter: place.formatter)
                }
                HStack {
                    Text("Lon: ")
                    TextField("Enter Longitude", value: $region.center.longitude, formatter: place.formatter)
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
