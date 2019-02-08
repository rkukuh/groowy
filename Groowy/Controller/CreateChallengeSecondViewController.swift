//
//  CreateChallengeSecondViewController.swift
//  Groowy
//
//  Created by David-UC on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class CreateChallengeSecondViewController: SwipeFormViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func swipeBack(sender:UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
