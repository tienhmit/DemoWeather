//
//  CoreDataConvertible.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/2/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataConvertible {
    associatedtype ObjectType: NSManagedObject
    static var entityName: String { get }
    var keyPridicate: NSPredicate { get }
    init(from object: ObjectType)
    func copy(to object: ObjectType, coreDataAccess: NSManagedObjectContext)
}
