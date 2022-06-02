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
    
    

}
