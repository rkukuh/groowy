//
//  State.swift
//  Groowy
//
//  Created by R. Kukuh on 11/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation

struct State {
    var current: Dialog?
    var history: [Dialog] = []
    
    mutating func nextState(answerIndex: Int) {
        if let current = self.current {
            history.append(current)
            
            if answerIndex < current.answers.count {
                self.current = current.answers[answerIndex].nextDialog
            } else {
                print("Invalid answer")
            }
        } else {
            print("Empty state")
        }
    }
}
