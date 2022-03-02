//
//  CityLocationModel+CoreData.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/2/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Foundation
import CoreData

extension CityLocationModel: CoreDataConvertible {
    
    typealias ObjectType = CityLocation
    
    static var entityName: String {
        "CityLocation"
    }
    
    var keyPridicate: NSPredicate {
        NSPredicate(format: "name = %@", name)
    }
    
    init(from object: CityLocation) {
        name = object.name ?? ""
        latitude = object.latitude
        longitude = object.longitude
        country = object.country ?? ""
    }
    
    func copy(to object: CityLocation, coreDataAccess: NSManagedObjectContext) {
        object.name = name
        object.latitude = latitude
        object.longitude = longitude
        object.country = country
    }
}

extension CityLocationModelCoreDataConditionType: CoreDataConditions {
    var sortLists: [NSSortDescriptor] {
        [NSSortDescriptor(key: "name", ascending: false)]
    }
    
    var predicate: NSPredicate? {
        nil
    }
    
    var limit: Int? {
        switch self {
        case .one:
            return 1
        case .all:
            return nil
        }
    }
    
    var offset: Int? {
        nil
    }
}
