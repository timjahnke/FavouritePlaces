//
//  PlaceViewModel.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 5/5/2022.
//

import Foundation
import CoreData
import SwiftUI

// Extends the existing Class Place from the CoreData database.
extension Place {
    // Sets optional properties to non-optional ViewModel properties
    var placeTitle: String {
        get { title ?? "" }
        set { title = newValue}
    }
    // Sets optional properties to non-optional ViewModel properties
    var placeDetails: String {
        get { details ?? "" }
        set { details = newValue}
    }
    // Sets optional properties to non-optional ViewModel properties
    var placeUrl: String {
        get { url ?? "" }
        set { url = newValue}
    }
    // Sets optional properties to non-optional ViewModel properties
    var placeLatitude: String {
        get { latitude ?? "" }
        set { latitude = newValue}
    }
    // Sets optional properties to non-optional ViewModel properties
    var placeLongitude: String {
        get { longitude ?? "" }
        set { longitude = newValue}
    }
    
}
