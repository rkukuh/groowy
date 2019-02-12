//
//  Dialog.swift
//  Groowy
//
//  Created by R. Kukuh on 11/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation

class Dialog {
    var text: String?
    var answers: [DialogAnswer] = []
    
    init (_ text: String) {
        self.text = text
    }
}
