//
//  PromiseCreateChallengeViewController.swift
//  Groowy
//
//  Created by David-UC on 2/13/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class PromiseCreateChallengeViewController: SwipeFormViewController {
    var oke:Bool = false
    var createChallengeController: CreateChallengeController?
    
    @IBAction func didTapPromiseButton(sender: UIButton) {
        /*if let createChallengeController = createChallengeController {
            createChallengeController.didPromiseTap()
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var promiseButton: UIImageView!
    
    @IBOutlet weak var xxx: UIView!
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    if(touch.view == xxx){
                        let force = touch.force/touch.maximumPossibleForce
                        let notification = UINotificationFeedbackGenerator()
                        if (force > 0.8 && oke == false){
                            oke = true
                            notification.notificationOccurred(.success)
                        }
                        if (force <= 0.5){oke = false }
                        print("\(force)%force")
                    }
                }
            }
        }
    }

    
}
