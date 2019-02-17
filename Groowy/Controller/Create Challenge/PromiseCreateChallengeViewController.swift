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
    var promiseView:UIView?
    var createChallengeController: CreateChallengeController?
    
    @IBAction func didTapPromiseButton(sender: UIButton) {
        if self.traitCollection.forceTouchCapability != .available {
            let notification = UINotificationFeedbackGenerator()
            notification.notificationOccurred(.success)
            self.createChallengeController?.didPromiseTap()
            self.isParentDismiss = true
            self.dismiss(animated: true, completion: nil)
        }
        /*if let createChallengeController = createChallengeController {
            createChallengeController.didPromiseTap()
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promiseView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        promiseView?.backgroundColor = COLOR_THEME_PRIMARY
        //self.view.addSubview(promiseView!)
        self.view.insertSubview(promiseView!, belowSubview: buttonTapTemp)
    }
    @IBOutlet weak var promiseButton: UIImageView!
   
    @IBOutlet weak var buttonTapTemp: UIButton!
    
    @IBAction func clickedPromisedButton(_ sender: UITapGestureRecognizer) {
        if self.traitCollection.forceTouchCapability != .available {
            let notification = UINotificationFeedbackGenerator()
            notification.notificationOccurred(.success)
            self.createChallengeController?.didPromiseTap()
            self.isParentDismiss = true
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var xxx: UIView!
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if(touch.view == xxx){
                oke = false
                promiseView?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if(touch.view == xxx){
                oke = false
                promiseView?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    if(touch.view == xxx){
                        let force = touch.force / 4.0
                        promiseView?.frame = CGRect(x: self.view.frame.width / 2 - self.view.frame.width / 2 * force, y: self.view.frame.height / 2 - self.view.frame.height / 2 * force, width: self.view.frame.width * force, height:  self.view.frame.height * force)
                        let notification = UINotificationFeedbackGenerator()
                        if (force > 1.0 && oke == false){
                            oke = true
                            notification.notificationOccurred(.success)
                            self.createChallengeController?.didPromiseTap()
                            self.isParentDismiss = true
                            //self.dismiss(animated: true, completion: nil)
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "dashboard") as! DashboardViewController
                            self.present(newViewController, animated: false, completion: nil)
                        }
                        if (force <= 0.1){
                            oke = false
                            promiseView?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                        }
                        print("\(force)%force")
                    }
                }
            }
        }
    }

    
}
