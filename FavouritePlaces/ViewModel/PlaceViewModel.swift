//
//  PlaceViewModel.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 5/5/2022.
//

import Foundation
import CoreData
import CoreLocation
import UIKit
import SwiftUI
import MapKit


// Store Images so they are not downloaded each time. Checks this array if already existing.
fileprivate var downloadedImages = [URL: Image]()

// Store Sunrise/ Sunset so they are not downloaded each time. Checks this array if already existing.
fileprivate var sunriseSunsetCache = [URL: SunriseSunset]()

// Extends the existing Class Place from the CoreData database.
extension Place {
    
    // Computed property from title in CoreData
    var placeTitle: String {
        // Sets optional properties to non-optional. Perform nil-coalescing. Nil will be an empty string.
        get { title ?? "" }
        // Store new value
        set { title = newValue}
    }
    
    // Computed property from details in CoreData
    var placeDetails: String {
        // Sets optional properties to non-optional. Perform nil-coalescing. Nil will be an empty string.
        get { details ?? "" }
        // Store new value
        set { details = newValue}
    }
    
    // Computed property from details in CoreData
    var placeUrl: String {
        // Sets optional properties to non-optional. Perform nil-coalescing. Nil will be an empty string.
        get { url ?? "" }
        // Store new value
        set { url = newValue}
    }
    
    // Computed property from latitude in CoreData
    var placeLatitude: Double {
        // Gets the latitude from CoreData.
        get { latitude }
        // Store new value
        set { latitude = newValue} 
    }
    
    // Computed property from longitude in CoreData
    var placeLongitude: Double {
        // Gets the longitude from CoreData.
        get { longitude }
        // Store new value
        set { longitude = newValue}
    }
    
    // Function to create a region using Latitude and Longitude metres.
    ///     Parameters:
    ///     centerLatitude: Float , centerLongitude: Float
    ///     Returns an MKCoordinateRegion()
    func createCoordinates(centerLatitude: CLLocationDegrees, centerLongitude: CLLocationDegrees) -> MKCoordinateRegion {
        // Returns an MKCoordinate region using parameters with a default latitude/longitude metres of 5000
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude), latitudinalMeters: 5000, longitudinalMeters: 5000)
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
            // Return the Number Format
            return numFormat
        }
    }
    
    // Computed variable for sunrise in CoreData
     var placeSunrise: String {
         // Sets optional properties to non-optional. Perform nil-coalescing. Nil will be an empty string.
         get { sunrise ?? ""}
         // Stores the new value.
         set { sunrise = newValue }
     }
    
    // Computed variable for sunset in CoreData
    var placeSunset: String {
        // Sets optional properties to non-optional. Perform nil-coalescing. Nil will be an empty string.
        get { sunset ?? "" }
        // Stores the new value.
        set { sunset = newValue}
    }
    
    // Computed variable for name in CoreData
    var placeName: String {
        // Sets optional properties to non-optional. Perform nil-coalescing. Nil will be an empty string.
        get { name ?? "" }
        // Stores the new value.
        set { name = newValue }
    }
    
    
    // Function to get images from a web URL
    ///         Parameters: None
    ///         Returns an Image
    func getImage() -> Image {
        // Try convert string to URL, else return default
        guard let url = URL(string: placeUrl)
        // Return a default image 
        else { return Image(systemName: "location.square") }
        // If image already exists, find as association in array
        if let image = downloadedImages[url] { return image }
        
        // Try get data from url to return a UIImage, else return default image.
        guard let data = try? Data(contentsOf: url),
              let uiImg = UIImage(data: data)
        // Return a default image.
        else { return Image(systemName: "location.square")}
        
        // On successful data, create an Image with a uiImage.
        let image = Image(uiImage: uiImg).resizable()
        // Add the image to the downloaded images cache. 
        downloadedImages[url] = image
        // Return the image
        return image
    }
    
    // Asynchronous function for request of Sun Data
    /// Parameters: None
    /// Return: Struct SunriseSunset or Nil
    func download() async -> SunriseSunset? {
        // Create a dynamic URL string that uses Place computed coordinates.
        let urlString = "https://api.sunrise-sunset.org/json?lat=\(placeLatitude)&lng=\(placeLongitude)"
        
        // Check if it is a valid URL for the API.
        guard let url = URL(string: urlString)
        // Else print a URL error and Return Nil.
        else {
            print("Malformed string: ", placeUrl)
            return nil }
        
        // If url already exists, find as association in array
        // Check if url exists in url cache array
        if let data = sunriseSunsetCache[url] { return data }
        
        // Request download of the data
        let request = URLRequest(url: url)
        
        // Coordinates network data tasks. Default configuration.
        let session = URLSession(configuration: .default)
        
        // Check for destructured elements in results from session. 
        guard let (jsonData, _) = try? await session.data(for: request, delegate: nil)
        // Else print an error message and Return nil.
        else {
            print("Could not look up Sunrise/ Sunset. ")
            return nil
        }
        
        // Check if JSON data is decodable
        guard let api = try? JSONDecoder().decode(SunriseSunsetAPI.self, from: jsonData)
        // Else print decoding error and Return Nil.
        else {
            print("Could not decode JSON API:\n\(String(data: jsonData, encoding: .utf8) ?? "<empty>")")
            return nil
        }
        // Convert the API results time to current time zone. Return the API results.
        let converted = api.results.converted(from: .init(secondsFromGMT: 0), to: .current)
        
        // Add the data to the downloaded data cache.
        sunriseSunsetCache[url] = converted
        return converted
    }
    
    @discardableResult
    // Save function that uses the managed object context of the class Place. Saves to context. Return boolean
    ///         Parameters: None
    ///         Returns a boolean based on if save was successful.
    ///         Discardable results enables ignore of return value.
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
   
    // To Add a new place to the list
    // Convenience initialiser used to call default initialiser.
    // Initialise context from NSManagedObjectContext.
    ///      Parameters: None
    ///      Return: None
    convenience init(addingInto context: NSManagedObjectContext) {
        // Add context to initialiser.
        self.init(context: context)
        withAnimation {
            // Initialise default values to store in CoreData
            self.id = UUID()
            self.timestamp = Date()
            self.title = "New Place"
            self.details = ""
            self.latitude = 0.0
            self.longitude = 0.0
            self.url = ""
            // Attempt to save to view context using function inside ViewModel otherwise throw an error
            self.save()
        }
    }
 
    // Delete places from the list.
    ///     Parameters: An array of Places, NSManagedObjectContext
    ///     return: None, Can throw a FatalError.
    ///     Creating a static function to allow use without creating an instance first.
    static func delete(_ places: [Place], from context: NSManagedObjectContext) {
        withAnimation {
            // For each element retrieved from the array of Places, Delete each NSObject from array at that index.
            places.forEach(context.delete)
            do {
                // Attempt to save to view context otherwise throw an error
                try context.save()
            } catch {
                // fatalError() causes the application to generate a crash log and terminate. For development purposes.
                let nsError = error as NSError
                // Return the error as a string with user information.
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
