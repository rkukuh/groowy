//
//  Reflection+CoreDataProperties.swift
//  Groowy
//
//  Created by R. Kukuh on 13/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//
//

import Foundation
import CoreData


extension Reflection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reflection> {
        return NSFetchRequest<Reflection>(entityName: "Reflection")
    }

    @NSManaged public var body: String?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var picture: NSData?
    @NSManaged public var challenge: Challenge?

}
