//
//  LocationViewModel.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 5/5/2022.
//

import Foundation
import CoreData
import UIKit
import SwiftUI
import MapKit

// Extends the existing Class Place from the CoreData database.
extension Location {
   
    // Sets optional properties to non-optional ViewModel properties
    var locationLatitude: Double {
        get { latitude }
        set { latitude = newValue}
    }
    // Sets optional properties to non-optional ViewModel properties
    var locationLongitude: Double {
        get { longitude }
        set { longitude = newValue}
    }
    
    var region: MKCoordinateRegion {
        get {
            // Use Function below for creating computed region using computed coordinates
            createCoordinates(centerLatitude: locationLatitude, centerLongitude: locationLongitude)
        }
        set {
            locationLatitude = newValue.center.latitude
            locationLongitude = newValue.center.longitude
            // Objectwillchange.send()
        }
    }
    
    // Format double to string for display for view
    var formatter: NumberFormatter {
        get {
            let temp = NumberFormatter()
            temp.allowsFloats = true
            temp.numberStyle = .decimal
            return temp
        }
    }
    
        // create region with no span. Uses latitude and longitude metres.
    func createCoordinates(centerLatitude: CLLocationDegrees, centerLongitude: CLLocationDegrees) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude), latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
    
    @discardableResult
    // Save function that uses the managed object context of the class Place. Saves to context. Return boolean
    func save() -> Bool {
        // Try save to managed object context
        do {
            try managedObjectContext?.save()
        // Throw if cannot save. Print error description.
        } catch {
            print("Error saving: \(error)")
            return false
        }
        return true
    }
}


