//
//  CreateChallengeSecondViewController.swift
//  Groowy
//
//  Created by David-UC on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class BodyCreateChallengeViewController: SwipeFormViewController, UIViewNextQuestionDelegate {

    var createChallengeController: CreateChallengeController?
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        if let  nextQuestionView = loadViewFromNib(nibName: "UIViewNextQuestion") as? UIViewNextQuestion {
            bodyTextView.inputAccessoryView = nextQuestionView
            nextQuestionView.delegate = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createChallengeController = createChallengeController {
            createChallengeController.didAddField(field: "body", value: bodyTextView.text)
            
            if let segueDestination = segue.destination as? GoalCreateChallengeViewController {
                segueDestination.createChallengeController = createChallengeController
            }
        }
    }
    
    func didTapNextButton() {
        performSegue(withIdentifier: "goalSegue", sender: nil)
    }
    
}
