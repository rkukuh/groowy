//
//  Answer.swift
//  Groowy
//
//  Created by R. Kukuh on 11/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation

struct DialogAnswer {
    var text: String?
    var nextDialog: Dialog?
    
    init (_ text: String, then nextDialog: Dialog?) {
        self.text = text
        self.nextDialog = nextDialog
    }
}
