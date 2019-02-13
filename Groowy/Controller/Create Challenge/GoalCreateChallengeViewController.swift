//
//  GoalCreateChallengeViewController.swift
//  Groowy
//
//  Created by David-UC on 2/13/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class GoalCreateChallengeViewController: SwipeFormViewController, UIViewNextQuestionDelegate {

    var createChallengeController: CreateChallengeController?
    @IBOutlet weak var goalTextView: UITextView!
    
    override func viewDidLoad() {
        if let  nextQuestionView = loadViewFromNib(nibName: "UIViewNextQuestion") as? UIViewNextQuestion {
            goalTextView.inputAccessoryView = nextQuestionView
            nextQuestionView.delegate = self 
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createChallengeController = createChallengeController {
            createChallengeController.didAddField(field: "goal", value: goalTextView.text)
            
            if let segueDestination = segue.destination as? ReminderCreateChallengeViewController {
                segueDestination.createChallengeController = createChallengeController
            }
        }
    }
    
    func didTapNextButton() {
        performSegue(withIdentifier: "reminderSegue", sender: nil)
    }
}
