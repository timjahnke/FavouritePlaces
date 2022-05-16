//
//  MapViewModel'.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 15/5/2022.
//

import Foundation
import Combine
import MapKit

class MapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), latitudinalMeters: 5000, longitudinalMeters: 5000)
}
