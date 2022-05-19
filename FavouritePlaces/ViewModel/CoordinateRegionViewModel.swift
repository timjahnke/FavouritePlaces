//
//  CoordinateRegionViewModel.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 14/5/2022.
//

import Foundation
import MapKit
import SwiftUI

// Extension of the existing class for an MKCoordinateRegion
extension MKCoordinateRegion: Equatable {
    
    // Computed property for getting the current latitude of a region as a string.
    var latitudeString: String {
        // Gets the current latitude of a region as a string
        get { "\(center.latitude)"}
        // Store new value as a double else return nothing
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            center.latitude = degrees
        }
    }
    
    // Computed property for getting the current longitude of a region as a string.
    var longitudeString: String {
        // Gets the current longitude of a region as a string
        get { "\(center.longitude)"}
        // Store new value as a double else return nothing
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            center.longitude = degrees
        }
    }
    
    // Function for equatable conformance
    ///     Parameters: lhs: MKCoordinateRegion, rhs: MKCoordinateRegion
    ///     Return a boolean on whether the above parameters are equal. 
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.center.latitude == rhs.center.latitude && lhs.center.longitude == rhs.center.longitude
    }
}

