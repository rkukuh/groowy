//
//  CreateChallengeViewController.swift
//  Groowy
//
//  Created by David-UC on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class TitleCreateChallengeViewController: SwipeFormViewController, UIViewNextQuestionDelegate {

    @IBOutlet weak var titleTextView: UITextView!
    var createChallengeController = CreateChallengeController()
    
    override func viewDidLoad() {
        if let  nextQuestionView = loadViewFromNib(nibName: "UIViewNextQuestion") as? UIViewNextQuestion {
            titleTextView.inputAccessoryView = nextQuestionView
            nextQuestionView.delegate = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        createChallengeController.didAddField(field: "title", value: titleTextView.text)
        
        if let segueDestination = segue.destination as? BodyCreateChallengeViewController {
            segueDestination.createChallengeController = createChallengeController
        }
    }
    
    func didTapNextButton() {
        performSegue(withIdentifier: "bodySegue", sender: nil)
    }
    
    

}