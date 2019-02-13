//
//  CreateChallengeControllerViewController.swift
//  Groowy
//
//  Created by David-UC on 2/13/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import CoreData

class CreateChallengeController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchedResults: NSFetchedResultsController<Challenge>!
    
    func didAddField(field: String, value: String) {
        // Get data from user input
    }
    
    func didPromiseTap() {
        // Persist to Core Data
        
        let challenge = Challenge(entity: Challenge.entity(), insertInto: context)
        
        challenge.title = ""
    }
}
