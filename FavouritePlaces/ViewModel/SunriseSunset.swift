//
//  SunriseSunset.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 24/5/2022.
//

import Foundation

struct SunriseSunset: Codable {
    var sunrise: String
    var sunset: String
    
    mutating func convert(from currentTimeZone: TimeZone!, to newTimeZone: TimeZone!) {
        let inputFormatter = DateFormatter()
        inputFormatter.dateStyle = .none
        inputFormatter.timeStyle = .medium
        inputFormatter.timeZone = currentTimeZone
        
        // output formatter is current timezone
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .none
        outputFormatter.timeStyle = .medium
        outputFormatter.timeZone = newTimeZone
        
        if let time = inputFormatter.date(from: sunrise) {
            sunrise = outputFormatter.string(from: time)
        }
        if let time = inputFormatter.date(from: sunset) {
            sunset = outputFormatter.string(from: time)
        }
    }
    
    // forces unwrapped values with !
    func converted(from currentTimeZone: TimeZone!, to newTimeZone: TimeZone!) -> SunriseSunset {
        var copy = self
        copy.convert(from: currentTimeZone, to: newTimeZone)
        return copy
    }
    
}

struct SunriseSunsetAPI: Codable {
    var results: SunriseSunset
    var status: String?
}
