//
//  MapViewModel.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 31/5/2022.
//

import Foundation
import MapKit

// Class MapViewModel
// A class ViewModel created for the MapView. Is observable.
class MapViewModel: ObservableObject {
    
    // A published variable to observe the region used for the map.
    @Published var region: MKCoordinateRegion
    
    // Create a lazy variable to create a computed publisher. Is created only when requested.
    // Created using a closure followed by a function call as it is used after created.
    lazy var publisher = {
        // Manually control published changes. Changes are published only after 1 second ellapses.
        // Changes are published on the main loop.
        objectWillChange.debounce(for: 1, scheduler: RunLoop.main)
    }()
    
    // Create constant of the Extension Class Place
    let place: Place
    
    // Sets initial values and parameters for use of MapViewModel.
    /// Parameter: (place: Class Place)
    /// Sets Extension Class Place values to be referenceable inside MapViewModel.
    /// Return: None
    init(place: Place) {
        self.place = place
        // Region is not declared as parameter as published variable for region declared above.
        
        /// Creates a region using MKCoordinate region from computed variables in Extention Class Place. Sets a default span.
        /// On Mapview, placeLatitude & placeLongitude store most recent coordinates.
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.placeLatitude, longitude: place.placeLongitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
    
    // Computed variable for referencing Place title for map.
    var title: String {
        // Get the computed title from Extension Place.
        get {
            place.placeTitle
        }
        // Computed title equals the new value. Publish the changes.
        set {
            place.placeTitle = newValue
            objectWillChange.send()
        }
    }
    
    var latitude: Double {
        // Get the computed latitude from Extension Place
        get {
            place.placeLatitude
        } set {
            // If the value is a valid latitude, store the new value
            if(place.placeLatitude >= -90.00 && place.placeLatitude <= 90.00 ) {
                place.placeLatitude = newValue
            }
            // Else set an initial value of 0 to prevent the map from crashing the app.
            else {
                place.placeLatitude = 0.00
            }
            // Publish the changes. 
            objectWillChange.send()
        }
    }
    var longitude: Double {
        // Get the computed longitude from Place
        get {
            place.placeLongitude
        } set {
            // If the value is a valid latitude, store the new value
            if(place.placeLongitude >= -180.00 && place.placeLongitude <= 180.00 ) {
                place.placeLongitude = newValue
            }
            // Else set an initial value of 0 to prevent the map from crashing the app.
            else {
                place.placeLongitude = 0.00
            }
            objectWillChange.send()
        }
    }
    
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
