//
//  PlaceViewModel.swift
//  FavouritePlacesTests
//
//  Created by Tim Jahnke on 19/5/2022.
//

import XCTest
import MapKit
import CoreData

class PlaceViewModel: XCTestCase {

    // This gets run before every test case
//    override class func setUp() {
//        // wipe database so that is is empty
//        let managedObjectContext = PersistentController().container.viewContext
//        Place(context: managedObjectContext)
//        managedObjectContext.save()
//    }
    
    
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
        let place = testPlace(title: "hello", details: "the details")
        XCTAssertEqual(place.title, "hello")
        
        // Test setter and assert equal boolean
        place.title = "goodbye"
        XCTAssertEqual(place.title, "goodbye")

    }
    
    // Create regions to compare for test equal assertion
    func testRegion() {
        // Create identical regions to compare based on practice in Place ViewModel
        let region1 = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.4705, longitude: 153.0260), latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        let region2 = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.4705, longitude: 153.0260), latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        // Test regions for equality
        XCTAssertEqual(region1, region2)
    }
    
    // test core data stuff
    
    //
//    var context: NSManagedObjectContext
    
//    override func setUp() {
//        context = PersistenceController().container.viewContext
//        do {
//            for result in items {
//                context.delete(result)
//            }
//            try context.save()
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
    
//    var items: [Person] = {
//        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
//        do {
//            return try context.fetch(fetchRequest)
//        } catch {
//            XCTFail(error.localizedDescription)
//            return []
//        }
//    }
    
//    func testAddPerson() {
//    do {
//        let person = try Person.add(to: context, firstName: "Hello", lastName: "World")
//        let results = items;
//        XCTAssertFalse(results.isEmpty)
//        if results?.isEmpty {
//            return
//        }
//        XCTAssertEqualj(person, results[0])
//    }
    
//    func testDelete() {
//        do {
//            let person = try person.add(to: context, firstName: "Hello", lastname: "World")
//            XCTAssertFalse(items.isEmpty)
//            try Person.delete(in: context, items: items)
//            XCTAssertTrue(items.isEmpty)
//        } catch {
//            
//        }
//    }
    
}
