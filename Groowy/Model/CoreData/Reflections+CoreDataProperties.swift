//
//  Reflections+CoreDataProperties.swift
//  Groowy
//
//  Created by R. Kukuh on 13/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//
//

import Foundation
import CoreData


extension Reflections {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reflections> {
        return NSFetchRequest<Reflections>(entityName: "Reflections")
    }

    @NSManaged public var body: String
    @NSManaged public var created_at: NSDate?
    @NSManaged public var picture: NSData?
    @NSManaged public var challenge: Challenges

}
