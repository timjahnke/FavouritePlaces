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
    
    var body: some View {
        if(editMode?.wrappedValue == .inactive) {
            VStack {
                Map(coordinateRegion: $place.placeRegion)
                HStack {
                    Text("Lat: ")
                    Text(place.placeRegion.latitudeString)
                }
                HStack {
                    Text("Lon: ")
                    Text(place.placeRegion.longitudeString)
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
                Map(coordinateRegion: $place.placeRegion )
                HStack {
                    Text("Lat: ")
                    TextField("Enter Latitude", text: $place.placeRegion.latitudeString)
                }
                HStack {
                    Text("Lon: ")
                    TextField("Enter Longitude", text: $place.placeRegion.longitudeString)
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
