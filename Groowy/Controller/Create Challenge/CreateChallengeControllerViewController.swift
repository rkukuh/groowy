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
    
    var challenge: [String: String] = [:]
    
    var fetchedResults: NSFetchedResultsController<Challenge>!
    
    func didAddField(field: String, value: String) {
        challenge[field] = value
    }
    
    func didPromiseTap() {
        let title = challenge["title"]
        
        print(title)
    }
}
