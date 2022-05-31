//
//  MapViewModel.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 31/5/2022.
//

import Foundation
import MapKit

// A class ViewModel created for the MapView. Observable.
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
            // Publish the changes.
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
        // Get the computed longitude from Extension Place
        get {
            place.placeLongitude
        } set {
            // If the value is a valid longitude, store the new value
            if(place.placeLongitude >= -180.00 && place.placeLongitude <= 180.00 ) {
                place.placeLongitude = newValue
            }
            // Else set an initial value of 0 to prevent the map from crashing the app.
            else {
                place.placeLongitude = 0.00
            }
            // Publish the changes.
            objectWillChange.send()
        }
    }
    
    // Look up coordinates from a name
    /// Parameters: (place: String)
    /// Return: None
    func lookupCoordinates(for place: String) {
        // Constant the creates a geocoder for converting between geographic coordinates and place names.
        let coder = CLGeocoder()
        
        // Use the string parameter for geocoding name to coordinates.
        coder.geocodeAddressString(place) { optionalPlacemarks, optionalError in
            
            // Print an error if unable to find place & Return
            if let error = optionalError {
                print("Error looking up \(place): \(error.localizedDescription)")
                return
            }
            
            // Check if constant can equal optionalPlacemarks and the constant is not empty.
            // Print an error if empty & Return.
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            
            // Get the first index of the placemarks results array.
            // Only want the first result from geocoding.
            let placemark = placemarks[0]
            
            // Check if the placemark result has a location
            guard let location = placemark.location else {
                // Print an error message if no location coordinates found & Return.
                print("Placemark has no location")
                return
            }
            
            // Store the location coordinates in the MapViewModel variables.
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
    }
    
    // Look up a name from coordinates
    /// Parameters: (location: CLLocation)
    /// Return:  None
    func lookupName(for location: CLLocation) {
        // Constant the creates a geocoder for converting between geographic coordinates and place names.
        let coder = CLGeocoder()
        
        // Use the CLLocation parameter for geocoding coordinates into a location name.
        coder.reverseGeocodeLocation(location) { optionalPlacemarks, optionalError in
            
            // Print an error if unable to find place from coordinates & Return
            if let error = optionalError {
                print("Error looking up \(location.coordinate): \(error.localizedDescription)")
                return
            }
            
            // Check if constant can equal optionalPlacemarks and the constant is not empty.
            // Print an error if empty & Return.
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            
            // Get the first index of the placemarks results array.
            // Only want the first result from geocoding.
            let placemark = placemarks[0]
            
            // Destructured array of keypaths from the placemark. Used for printing.
//            for value in [
//                \CLPlacemark.name,
//                \.country,
//                \.isoCountryCode,
//                \.postalCode,
//                \.administrativeArea,
//                \.subAdministrativeArea,
//                \.locality,
//                \.subLocality,
//                \.thoroughfare,
//                \.subThoroughfare
//            ] {
                // For printing the results of geocoding
//                print(String(describing: placemark[keyPath: value]))
//            }
            
            // Order of precedence of the place name to be stored from placemark.
            // Last result is an empty string.
            self.place.placeName = placemark.subAdministrativeArea ?? placemark.locality ?? placemark.subLocality ?? placemark.name ?? placemark.thoroughfare ?? placemark.subThoroughfare ?? placemark.country ?? ""
        }
    }
}
