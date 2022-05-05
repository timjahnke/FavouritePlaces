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
    var placeDetails: String {
        get { details ?? "" }
        set { details = newValue}
    }
    var placeImage: String {
        get { image ?? "" }
        set { image = newValue}
    }
    var placeLatitude: String {
        get { latitude ?? "" }
        set { latitude = newValue}
    }
    var placeLongitude: String {
        get { longitude ?? "" }
        set { longitude = newValue}
    }
    
}
