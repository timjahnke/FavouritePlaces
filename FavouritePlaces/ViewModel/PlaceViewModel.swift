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
import MapKit

// Default Image that is passed into getImage() function
fileprivate let defaultImage = Image(systemName: "location.square")

// Store Images so they are not downloaded each time. Checks this array if already existing.
fileprivate var downloadedImages = [URL: Image]()

// Extends the existing Class Place from the CoreData database.
extension Place {
   
    // Computed property from title in CoreData
    var placeTitle: String {
        // Sets optional properties to non-optional
        get { title ?? "" }
        // Store new value
        set { title = newValue}
    }
    
    // Computed property from details in CoreData
    var placeDetails: String {
        // Sets optional properties to non-optional
        get { details ?? "" }
        // Store new value
        set { details = newValue}
    }
    
    // Computed property from details in CoreData
    var placeUrl: String {
        // Sets optional properties to non-optional
        get { url ?? "" }
        // Store new value
        set { url = newValue}
    }
    
    // Computed property from latitude in CoreData
    var placeLatitude: Double {
        // Sets optional properties to non-optional
        get { latitude }
        // Store new value
        set { latitude = newValue} 
    }
    
    // Computed property from longitude in CoreData
    var placeLongitude: Double {
        // Sets optional properties to non-optional
        get { longitude }
        // Store new value
        set { longitude = newValue}
    }
    
    // Create a default region to pass to State Binding in MapView
    var region: MKCoordinateRegion {
        get {
            // Use Function below for creating computed region using computed coordinates 
            createCoordinates(centerLatitude: placeLatitude, centerLongitude: placeLongitude)
        }
        set {
            // Store computed values below with coordinates in new value
            placeLatitude = newValue.center.latitude
            placeLongitude = newValue.center.longitude
        }
    }
    
    // Format double to string for display in MapView textfield
    var formatter: NumberFormatter {
        get {
            // Create a number formatter and return with chosen formats
            let numFormat = NumberFormatter()
            // Formatter allows floats and decimals
            numFormat.allowsFloats = true
            numFormat.numberStyle = .decimal
            return numFormat
        }
    }

    // Function to create a region using Latitude and Longitude metres.
    ///     Parameters:
    ///     centerLatitude: Float , centerLongitude: Float
    ///     Returns an MKCoordinateRegion()
    func createCoordinates(centerLatitude: CLLocationDegrees, centerLongitude: CLLocationDegrees) -> MKCoordinateRegion {
        // Returns an MKCoordinate region using parameters with a default latitude/longitude metres of 5000
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude), latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
    
    // Function to get images from a web URL
    ///         Parameters: None
    ///         Returns an Image
    func getImage() -> Image {
        // Try convert string to URL, else return default
        guard let url = URL(string: placeUrl) else { return defaultImage }
        // If image already exists, find as association in array
        if let image = downloadedImages[url] { return image }
        
        // Try get data from url to return a UIImage, else return default image.
        guard let data = try? Data(contentsOf: url),
              let uiImg = UIImage(data: data) else { return
            defaultImage }
        
        // On successful data, create an Image with a uiImage.
        let image = Image(uiImage: uiImg).resizable()
        // Add the image to the downloaded images cache. 
        downloadedImages[url] = image
        // Return the image
        return image
    }
    
    @discardableResult
    // Save function that uses the managed object context of the class Place. Saves to context. Return boolean
    ///         Parameters: None
    ///         Returns a boolean based on if save was successful.
    func save() -> Bool {
        // Try save to managed object context
        do {
            try managedObjectContext?.save()
        // Throw if cannot save.
        } catch {
            // Print error description.
            print("Error saving: \(error)")
            return false
        }
        return true
    }
}


