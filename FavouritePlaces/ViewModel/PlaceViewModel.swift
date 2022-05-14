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

fileprivate let defaultImage = Image(systemName: "location.square")
fileprivate var downloadedImages = [URL: Image]()
var region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), latitudinalMeters: 5000, longitudinalMeters: 5000)

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
    
    var placeRegion: MKCoordinateRegion {
        get {
            region
        }
        set {
            guard let numLatitude = CLLocationDegrees(placeLatitude) else { return }
            guard let numLongitude = CLLocationDegrees(placeLongitude) else { return }
            region = createCoordinates(centerLatitude: numLatitude, centerLongitude: numLongitude)
        }
    }
    
    func createCoordinates(centerLatitude: CLLocationDegrees, centerLongitude: CLLocationDegrees) -> MKCoordinateRegion {
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude), latitudinalMeters: 5000, longitudinalMeters: 5000)
        return coordinateRegion
    }
    
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
        return image
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


