//
//  Motivation.swift
//  Groowy
//
//  Created by R. Kukuh on 13/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation

class Motivation {
    var body: String?
    var category: String?
    
    init (_ body: String, for category: String) {
        self.body = body
        self.category = category
    }
}
