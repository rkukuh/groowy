//
//  Challenges+CoreDataProperties.swift
//  Groowy
//
//  Created by R. Kukuh on 13/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//
//

import Foundation
import CoreData


extension Challenges {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenges> {
        return NSFetchRequest<Challenges>(entityName: "Challenges")
    }

    @NSManaged public var body: String
    @NSManaged public var created_at: NSDate?
    @NSManaged public var finished_at: NSDate?
    @NSManaged public var goal: String
    @NSManaged public var remind_at: NSDate?
    @NSManaged public var status: String
    @NSManaged public var title: String
    @NSManaged public var reflections: NSSet

}
