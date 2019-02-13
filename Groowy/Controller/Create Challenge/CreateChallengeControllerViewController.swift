//
//  CreateChallengeControllerViewController.swift
//  Groowy
//
//  Created by David-UC on 2/13/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class CreateChallengeController {
    
    var challenge:[String:String] = [:]
    
    func didAddField(field: String, value: String) {
        challenge[field] = value
    }
    
    func didPromiseTap() {
        let title = challenge["title"]
        
        print(title)
    }
}
