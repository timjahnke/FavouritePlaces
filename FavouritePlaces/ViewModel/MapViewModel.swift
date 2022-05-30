//
//  MapViewModel.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 31/5/2022.
//

import Foundation
import MapKit

class MapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    
    lazy var publisher = {
        objectWillChange.debounce(for: 1, scheduler: RunLoop.main)
    }()
    
    let place: Place
    init(place: Place) {
        self.place = place
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.placeLatitude, longitude: place.placeLongitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
    
    var title: String {
        get {
            place.placeTitle
        }
        set {
            place.placeTitle = newValue
            objectWillChange.send()
        }
    }
    
    var latitude: Double {
        get {
            place.placeLatitude
        } set {
            place.placeLatitude = newValue
            objectWillChange.send()
        }
    }
    var longitude: Double {
        get {
            place.placeLongitude
        } set {
            place.placeLongitude = newValue
            objectWillChange.send()
        }
    }
    
    
//
//    func geocode() {
//        region.center.latitude = //
//        region.center.longitude = //
//    }
    
    // Look up coordinates from a name
    func lookupCoordinates(for place: String) {
        let coder = CLGeocoder()
        coder.geocodeAddressString(place) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(place): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            let placemark = placemarks[0]
            guard let location = placemark.location else {
                print("Placemark has no location")
                return
            }
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            // fix this add in a region from the coordinate view model
//            self.region = createCoordinates(centerLatitude: location.coordinate.latitude, centerLongitude: location.coordinate.longitude)
            print("lookup coord fired")
//            print("self.lat:", self.latitude)
//            print("self.lon:", self.longitude)
            print("location", location.coordinate)
            print("the region", self.region)
        }
    }
    
    // Look up a name from coordinates
    func lookupName(for location: CLLocation) {
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(location) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(location.coordinate): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            let placemark = placemarks[0]
            for value in [
                \CLPlacemark.name,
                \.country,
                \.isoCountryCode,
                \.postalCode,
                \.administrativeArea,
                \.subAdministrativeArea,
                \.locality,
                \.subLocality,
                \.thoroughfare,
                \.subThoroughfare
            ] {
                print(String(describing: placemark[keyPath: value]))
            }
            self.place.placeName = placemark.subAdministrativeArea ?? placemark.locality ?? placemark.subLocality ?? placemark.name ?? placemark.thoroughfare ?? placemark.subThoroughfare ?? placemark.country ?? ""
        }
    }
}
