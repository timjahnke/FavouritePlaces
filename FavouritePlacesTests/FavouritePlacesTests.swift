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

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    //  (place.placeUrl.hasPrefix("https://") && place.placeUrl.hasSuffix(".jpg")) ||
    // (place.placeUrl.hasPrefix("https://") && place.placeUrl.hasSuffix(".png"))
    
    //      if(place.placeDetails.count > 0) {
    // Check item name equals matching string
//    func testItemEqual() {
//        let name = "Milk"
//        let item = ItemModel(name: "Milk", isChecked: true)
//        XCTAssertEqual(item.name, name)
//    }
//
//    // Check item boolean
//    func testItemIsChecked() {
//        let item = ItemModel(name: "Bread", isChecked: true)
//        XCTAssertTrue(item.isChecked)
//    }
//
//    // Check item name is greater than 2 characters
//    func testItemNameLength() {
//        let item = ItemModel(name: "Chicken", isChecked: false)
//        XCTAssertGreaterThan(item.name.count, 2)
//    }
//
//    // Check item name and boolean is not nil
//    func testItemNotNil() {
//        let item = ItemModel(name: "Butter", isChecked: false)
//        XCTAssertNotNil(item.name)
//        XCTAssertNotNil(item.isChecked)
//    }

    
    // Check item array is not empty
    func testItemArray() {
        let items: [ItemModel] = [
            ItemModel(name: "Milk", isChecked: true),
            ItemModel(name: "Bread", isChecked: false),
            ItemModel(name: "Chicken", isChecked: false),
        ]
        XCTAssertNotNil(items)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
