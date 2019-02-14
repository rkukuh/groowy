//
//  Gift.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/13/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation

class Gift {
    var gifts: [String: [String]] = [:]
    var category: String?
    
    init () {
        //Insert for basic
        self.gifts[GiftCategory.basic.rawValue] =
            ["www.google.com",
             "www.apple.com",
             "www.glorious-institution.com",
             "www.uc.ac.id"
        ]
        //Isert for CBL
        self.gifts[GiftCategory.cbl.rawValue] =
            ["www.google.com",
             "www.apple.com",
             "www.glorious-institution.com",
             "www.uc.ac.id"
        ]
        
        //Insert for motivation
        self.gifts[GiftCategory.motivation.rawValue] =
            ["www.google.com",
             "www.apple.com",
             "www.glorious-institution.com",
             "www.uc.ac.id"
        ]
    }
    
    func getURL(category: GiftCategory) -> [String]?{
        return self.gifts[category.rawValue]
    }
}
