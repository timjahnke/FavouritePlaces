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
    
    // Check isFavourite boolean is true
    func testItemIsChecked() {
        let isFavourite = true
        XCTAssertTrue(isFavourite)
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
    
//    func testGetterAndSetters() {
//        var person = Person(name: "hello")
//        XCTAssertEqual(person.name, "hello")
//        
//        person.name = "goodbye"
//        XCTAssertEqual(person.name, "goodbye")
//        
//    }
    
    func testCreatePerson () {
        // xct assert equal create class
    }
    
//    func testIsCodable() {
//        let person = Person(name: "hello")
//        let encoder = JSONEncoder()
//        let decoder = JSONDecoder()
//        do {
//            let data = try encoder.encode(person)
//            let newPerson - try decoder.decode(Person.self, from: data)
//            XCTAssertEqual(person, newPerson)
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testIsEquatable() {
//        var person1 = Person(name: "hello")
//        var person2 = Person(name: "goodbye")
//        XCTAssertEqual(person1, person2)
//        person1.name = "bonjour"
//        XCTAssertNotEqual(person1, person2)
//    }
    
//    func testIsHashable() {
//        var set1: Set<Person> = Set()
//        let person1 = Person(name: "hello")
//        let person2 = Person(name: "hello")
//        set1.insert(person1)
//        XCTAssertTrue(set1.contains(person2))
//    }

}
