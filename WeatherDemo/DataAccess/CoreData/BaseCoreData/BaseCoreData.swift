//
//  BaseCoreData.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/2/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol BaseCoreDataInterface {
    func insert<T: CoreDataConvertible>(models: [T]) throws
    func delete<T: CoreDataConvertible>(models: [T]) throws
    func delete<T: CoreDataConvertible>(modelType: T.Type) throws
    func fetch<T: CoreDataConvertible>(conditions: CoreDataConditions) throws -> [T]
}

protocol CoreDataConditions {
    var sortLists: [NSSortDescriptor] { get }
    var predicate: NSPredicate? { get }
    var limit: Int? { get }
    var offset: Int? { get }
}

final class BaseCoreData {
    private let managedObjectContext: NSManagedObjectContext
    
    init() {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
    }
}

extension BaseCoreData: BaseCoreDataInterface {
    func insert<T>(models: [T]) throws where T : CoreDataConvertible {
        for model in models {
            guard let object = NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: managedObjectContext) as? T.ObjectType else {
                return
            }
            model.copy(to: object, coreDataAccess: managedObjectContext)
        }
        try save()
    }
    
    func delete<T>(models: [T]) throws where T : CoreDataConvertible {
        for model in models {
            guard let object = try fetchOne(modelType: T.self, predicate: model.keyPridicate) else {
                return
            }
            managedObjectContext.delete(object)
        }
        try save()
    }
    
    func delete<T: CoreDataConvertible>(modelType: T.Type) throws {
        let request: NSFetchRequest<NSFetchRequestResult> = createRequest(entityName: T.entityName)
        try managedObjectContext.execute(NSBatchDeleteRequest(fetchRequest: request))
        try save()
    }
    
    func fetch<T: CoreDataConvertible>(conditions: CoreDataConditions) throws -> [T] {
        let fetchRequest: NSFetchRequest<T.ObjectType> = createRequest(entityName: T.entityName,
                                                                       sortLists: conditions.sortLists,
                                                                       predicate: conditions.predicate,
                                                                       limit:  conditions.limit,
                                                                       offset: conditions.offset)
        return try fetch(fetchRequest: fetchRequest).map { T(from: $0) }
    }
}

private extension BaseCoreData {
    func fetch<T: NSManagedObject>(fetchRequest: NSFetchRequest<T>) throws -> [T] {
        try managedObjectContext.fetch(fetchRequest)
    }
    
    func fetchOne<T: CoreDataConvertible>(modelType: T.Type, predicate: NSPredicate) throws -> T.ObjectType? {
        let fetchRequest: NSFetchRequest<T.ObjectType> = createRequest(entityName: T.entityName, predicate: predicate)
        return try managedObjectContext.fetch(fetchRequest).first
    }
    
    func createRequest<T: NSFetchRequestResult>(entityName: String,
                                                sortLists: [NSSortDescriptor] = [],
                                                predicate: NSPredicate? = nil,
                                                limit: Int? = nil,
                                                offset: Int? = nil) -> NSFetchRequest<T> {
        let request = NSFetchRequest<T>()
        request.entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
        request.sortDescriptors = sortLists
        request.predicate = predicate
        request.fetchLimit = limit ?? 0
        request.fetchOffset = offset ?? 0
        return request
    }
    
    func save() throws {
        if managedObjectContext.hasChanges {
            try managedObjectContext.save()
        }
    }
}
