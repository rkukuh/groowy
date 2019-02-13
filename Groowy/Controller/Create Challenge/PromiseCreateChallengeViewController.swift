//
//  PromiseCreateChallengeViewController.swift
//  Groowy
//
//  Created by David-UC on 2/13/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class PromiseCreateChallengeViewController: SwipeFormViewController {

    var createChallengeController: CreateChallengeController?
    @IBOutlet weak var promiseButton: UIButton!
    
    @IBAction func didTapPromiseButton(sender: UIButton) {
        if let createChallengeController = createChallengeController {
            createChallengeController.didPromiseTap()
        }
    }

}
