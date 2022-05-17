//
//  CoordinateRegionViewModel.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 14/5/2022.
//

import Foundation
import MapKit
import SwiftUI

extension MKCoordinateRegion: Equatable {
    var latitudeString: String {
        get { "\(center.latitude)"}
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            center.latitude = degrees
        }
    }
    var longitudeString: String {
        get { "\(center.longitude)"}
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            center.longitude = degrees
        }
    }
    
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.center.latitude == rhs.center.latitude && lhs.center.longitude == rhs.center.longitude
    }
}

