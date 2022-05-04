//
//  Place+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Tim Jahnke on 5/5/2022.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var details: String?

}
