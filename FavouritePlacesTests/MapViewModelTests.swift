//
//  MapViewModelTests.swift
//  FavouritePlacesTests
//
//  Created by Tim Jahnke on 31/5/2022.
//

import XCTest
import MapKit

class MapViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Check for valid latitude within specified range
    func testLatitude() {
        // Set initial value
        let latitude = Double(10.00)
            // If the value is a valid latitude, return true
            XCTAssertTrue(latitude >= -90.00 && latitude <= 90.00 )
    }
    
    // Check for valid longitude within specified range
    func testLongitude() {
        // Set initial value
        let longitude = Double(20.00)
            // If the value is a valid latitude, return true
        XCTAssertTrue(longitude >= -180.00 && longitude <= 180.00 )
    }
    
    func testCreateRegion() {
        
        // create initial values as doubles
        let latitudeDouble = Double(-27.47)
        let longitudeDouble = Double(153.02)
        
        // Create Coordinates using CLLocationDegrees from doubles
        let latitudeDegrees = CLLocationDegrees(latitudeDouble)
        let longitudeDegrees = CLLocationDegrees(longitudeDouble)
    
        // Create a CLLocation of both coordinates.
        let location = CLLocationCoordinate2D(latitude: latitudeDegrees, longitude: longitudeDegrees)
        
        // Create identical regions to compare based on practice in Place ViewModel
        let region1 = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        let region2 = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.4705, longitude: 153.0260), latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        // Compare regions created from variables vs. statically. 
        XCTAssertEqual(region1, region2)
    }
    
    func testLookupCoordinatesForName() throws{
        // Set default result to false.
        var result = false;
        // Constant the creates a geocoder for converting between geographic coordinates and place names.
        let coder = CLGeocoder()
        
        // Use the string parameter for geocoding name to coordinates.
        coder.geocodeAddressString("Brisbane") { optionalPlacemarks, optionalError in
            
            // Return XCTFail if error on lookup.
            if let error = optionalError {
                return XCTFail("Error looking up Brisbane: \(error)")
            }
            
            // Check if constant can equal optionalPlacemarks and the constant is not empty.
            // Return XCTFail if empty.
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                return XCTFail("Placemarks came back empty")
            }
            
            // Get the first index of the placemarks results array.
            // Only want the first result from geocoding.
            let placemark = placemarks[0]
            
            // Check if the placemark result has a location
            guard let location = placemark.location else {
                // Return XCTFail if no location.
                return XCTFail("Placemark has no location")
            }
            
            // Get values from location
            var _ = location.coordinate.latitude
            var _ = location.coordinate.longitude
            // Change result to true
            result = true
            XCTAssertTrue(result)
        }
    }
}
