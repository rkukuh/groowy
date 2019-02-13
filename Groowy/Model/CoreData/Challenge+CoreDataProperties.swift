//
//  Challenge+CoreDataProperties.swift
//  Groowy
//
//  Created by R. Kukuh on 13/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//
//

import Foundation
import CoreData


extension Challenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenge> {
        return NSFetchRequest<Challenge>(entityName: "Challenge")
    }

    @NSManaged public var body: String?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var finished_at: NSDate?
    @NSManaged public var goal: String?
    @NSManaged public var remind_at: NSDate?
    @NSManaged public var status: String?
    @NSManaged public var title: String?
    @NSManaged public var reflections: NSSet?

}

// MARK: Generated accessors for reflections
extension Challenge {

    @objc(addReflectionsObject:)
    @NSManaged public func addToReflections(_ value: Reflection)

    @objc(removeReflectionsObject:)
    @NSManaged public func removeFromReflections(_ value: Reflection)

    @objc(addReflections:)
    @NSManaged public func addToReflections(_ values: NSSet)

    @objc(removeReflections:)
    @NSManaged public func removeFromReflections(_ values: NSSet)

}
