//
//  CityLocation+CoreDataProperties.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/2/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//
//

import Foundation
import CoreData


extension CityLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityLocation> {
        return NSFetchRequest<CityLocation>(entityName: "CityLocation")
    }

    @NSManaged public var country: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?

}
