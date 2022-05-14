//
//  MapView.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 14/5/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var region: MKCoordinateRegion
    @Environment(\.editMode) var editMode
    
    var body: some View {
        if(editMode?.wrappedValue == .inactive) {
            VStack {
                Map(coordinateRegion: $region )
                HStack {
                    Text("Latitude: ")
                    Text(region.latitudeString)
                }
                HStack {
                    Text("Longitude: ")
                    Text(region.longitudeString)
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
                Map(coordinateRegion: $region )
                HStack {
                    Text("Latitude: ")
                    TextField("Enter Latitude", text: $region.latitudeString)
                }
                HStack {
                    Text("Longitude: ")
                    TextField("Enter Longitude", text: $region.longitudeString)
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
