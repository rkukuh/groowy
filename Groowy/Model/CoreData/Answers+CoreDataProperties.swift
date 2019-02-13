//
//  Answers+CoreDataProperties.swift
//  Groowy
//
//  Created by R. Kukuh on 13/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//
//

import Foundation
import CoreData


extension Answers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answers> {
        return NSFetchRequest<Answers>(entityName: "Answers")
    }

    @NSManaged public var question: String
    @NSManaged public var userAnswer: String

}
