//
//  PlaceViewModel.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 5/5/2022.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

let defaultImage = Image(systemName: "location.square")

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
    
    func getImage() -> Image {
        guard let url = URL(string: placeUrl),
              let data = try? Data(contentsOf: url),
              let uiImg = UIImage(data: data) else { return
            defaultImage }
        return Image(uiImage: uiImg).resizable()
    }
    
  
    //.scaledToFit()
//    Image(systemName: "location.square").foregroundColor(.green).frame(width: 40, height: 40);
 
}


