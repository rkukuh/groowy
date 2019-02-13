//
//  Answer+CoreDataProperties.swift
//  Groowy
//
//  Created by R. Kukuh on 13/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//
//

import Foundation
import CoreData


extension Answer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer")
    }

    @NSManaged public var question: String?
    @NSManaged public var userAnswer: String?

}
