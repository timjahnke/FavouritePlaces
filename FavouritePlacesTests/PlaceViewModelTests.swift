//
//  PlaceViewModel.swift
//  FavouritePlacesTests
//
//  Created by Tim Jahnke on 19/5/2022.
//

import XCTest
import SwiftUI
import MapKit
import CoreData

struct SunriseSunsetTest: Codable {
    var sunrise: String;
    var sunset: String;
}

struct SunriseSunsetAPITest: Codable {
    var sunriseSunsetTest: SunriseSunsetTest;
    var status: String;
}

class PlaceViewModel: XCTestCase {
    func testGetterAndSetters() {
        // Create a test class to test getters and setters for test assertion.
        class testPlace {
            var title: String
            var details: String
            
            init(title: String, details: String) {
                self.title = title
                self.details = details
            }
        }
        // Test getter and assert equal boolean
        let place = testPlace(title: "Brisbane", details: "Capital City")
        XCTAssertEqual(place.title, "Brisbane")
        
        // Test setter and assert equal boolean
        place.title = "Sydney"
        XCTAssertEqual(place.title, "Sydney")

    }
    
    // Test conversion of doubles to CLLocationDegrees for map region
    func testCoordinatesConvert() {
        // create initial values as doubles
        let latitudeDouble = Double(-27.47)
        let longitudeDouble = Double(153.02)
        
        // Create Coordinates using CLLocationDegrees from doubles
        let latitudeDegrees = CLLocationDegrees(latitudeDouble)
        let longitudeDegrees = CLLocationDegrees(longitudeDouble)
        XCTAssertEqual(CLLocationDegrees(latitudeDouble), latitudeDegrees)
        XCTAssertEqual(CLLocationDegrees(longitudeDegrees), longitudeDegrees)
    }
    
    // Test code to create regions
    func testRegion() {
        // Create identical regions to compare based on practice in Place ViewModel
        let region1 = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.4705, longitude: 153.0260), latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        let region2 = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.4705, longitude: 153.0260), latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        // Test regions for equality
        XCTAssertEqual(region1, region2)
    }
    
    func testUrl() {
        // Try convert string to URL
        var result = false
        if (URL(string: "https://www.planetware.com/photos-large/AUS/australia-brisbane-city-2.jpg") != nil) {
            result = true
        }
        XCTAssertTrue(result)
    }
    
    // Test converting a url to a UI Image.
    func testImage() throws{
        // Try convert string to URL
        var result = false
        guard let url = URL(string: "https://www.planetware.com/photos-large/AUS/australia-brisbane-city-2.jpg") else {
            return XCTFail("Could not convert url from string.")
        }
       // Attempt get data from url
        guard let data = try? Data(contentsOf: url) else {
            return XCTFail("Could not get data contents from url.")
        }
        // Attempt to create a UI Image.
        guard let uiImg = UIImage(data: data) else {
            return XCTFail("Could not make image from data.")
        }
        // On successful data, create an Image with a uiImage.
        _ = Image(uiImage: uiImg).resizable()
        result = true
        return XCTAssertTrue(result)
    }
}
