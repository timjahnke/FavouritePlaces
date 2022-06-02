//
//  FavouritePlacesTests.swift
//  FavouritePlacesTests
//
//  Created by Tim Jahnke on 2/5/2022.
//

import XCTest
@testable import FavouritePlaces

class FavouritePlacesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Check url starts with "https://" and either ends with ".jpg" or ."png"
    func testURLSyntax() throws {
        let url = "https://www.planetware.com/photos-large/AUS/australia-brisbane-city-2.jpg"
        XCTAssertTrue(
            (url.hasPrefix("https://") && url.hasSuffix(".jpg")) ||
            (url.hasPrefix("https://") && url.hasSuffix(".png"))
            )
    }
   
    // Check if details is not an empty string
    func testDetails() throws {
        let details = "This city is the capital of Queensland, Australia."
        XCTAssertTrue(details.count > 0)
    }
    
    // Check title name is greater than 2 characters
    func testItemNameLength() {
        let title = "Brisbane"
        XCTAssertGreaterThan(title.count, 2)
    }

    // Check item name and boolean is not nil
    func testCoordinatesNotNil() {
        let latitude = 10.0
        let longitude = 20.0
        XCTAssertNotNil(latitude)
        XCTAssertNotNil(longitude)
    }

    // Default performance test case
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
