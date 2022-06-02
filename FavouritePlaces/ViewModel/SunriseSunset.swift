//
//  SunriseSunset.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 24/5/2022.
//

import Foundation

// Struct for encoding and decoding Sunset Sunrise data from the below struct SunriseSunsetAPI. 
struct SunriseSunset: Codable {
    var sunrise: String
    var sunset: String
    
    // function to convert from current timezone to new timezone. Is used for converting a copy below. 
    /// Parameters:
    /// CurrentTimeZone: TimeZone. For setting the input formatter's timezone.
    /// NewTimeZone: Timezone. For setting the output formatter's timezone.
    /// Forces unwrapped values with !
    mutating func convert(from currentTimeZone: TimeZone!, to newTimeZone: TimeZone!) {
        // Create a data formatter
        // Input formatter is the initial GMT time. 
        let inputFormatter = DateFormatter()
        // Set the desired styling and timezone for the input formatter
        inputFormatter.dateStyle = .none
        inputFormatter.timeStyle = .medium
        inputFormatter.timeZone = currentTimeZone
        
        // Create a data formatter
        // Output formatter is the current timezone.
        let outputFormatter = DateFormatter()
        // Set the desired styling and timezone for the input formatter
        outputFormatter.dateStyle = .none
        outputFormatter.timeStyle = .medium
        outputFormatter.timeZone = newTimeZone
        
        // Store results of initial time of sunrise
        if let time = inputFormatter.date(from: sunrise) {
            // Convert the results to the current time zone.
            sunrise = outputFormatter.string(from: time)
        }
        // Store results of initial time of sunset
        if let time = inputFormatter.date(from: sunset) {
            // Convert the results to the current time zone. 
            sunset = outputFormatter.string(from: time)
        }
    }
    
    // Forces unwrapped values with !
    func converted(from currentTimeZone: TimeZone!, to newTimeZone: TimeZone!) -> SunriseSunset {
        // create a copy
        var copy = self
        // Use the above convert function to convert the copy.
        copy.convert(from: currentTimeZone, to: newTimeZone)
        // Return the newly converted copy
        return copy
    }
}

// A struct for handling the API call of Sunrise Sunset data.
struct SunriseSunsetAPI: Codable {
    var results: SunriseSunset
    var status: String?
}
