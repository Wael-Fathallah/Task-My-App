//
//  Category+CoreDataProperties.swift
//  Task My App
//
//  Created by Fathallah Wael on 11/30/17.
//  Copyright © 2017 Fathallah Wael. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var colour: String?
    @NSManaged public var name: String?
    @NSManaged public var task: NSSet?

}

// MARK: Generated accessors for task
extension Category {

    @objc(addTaskObject:)
    @NSManaged public func addToTask(_ value: Task)

    @objc(removeTaskObject:)
    @NSManaged public func removeFromTask(_ value: Task)

    @objc(addTask:)
    @NSManaged public func addToTask(_ values: NSSet)

    @objc(removeTask:)
    @NSManaged public func removeFromTask(_ values: NSSet)

}
