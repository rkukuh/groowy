//
//  State.swift
//  Groowy
//
//  Created by R. Kukuh on 11/02/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation

struct DialogState {
    var current: Dialog?
    var history: [Dialog] = []
    
    mutating func nextState(answerIndex: Int) -> Bool {
        if let current = self.current {
            history.append(current)
            
            if answerIndex < current.answers.count {
                self.current = current.answers[answerIndex].nextDialog
                return self.current != nil ?  true : false
            } else {
                print("Invalid answer")
                return false            }
        } else {
            print("Empty state")
            return false
        }
    }
}
