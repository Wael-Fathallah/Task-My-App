//
//  Task+CoreDataProperties.swift
//  Task My App
//
//  Created by Fathallah Wael on 11/30/17.
//  Copyright © 2017 Fathallah Wael. All rights reserved.
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task");
    }

    @NSManaged public var completionDate: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var category: Category?

}
