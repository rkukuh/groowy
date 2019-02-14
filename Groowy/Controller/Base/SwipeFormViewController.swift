//
//  BaseViewController.swift
//  SwipeSheetViewController
//
//  Created by David-UC on 2/8/19.
//  Copyright © 2019 David-UC. All rights reserved.
//

import UIKit

class SwipeFormViewController: UIViewController {
    
    var previousVC:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func parentDismiss(animated flag: Bool, completion: (() -> Void)?) {
        super.dismiss(animated: true, completion: nil)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if flag {
            let firstView = self.view
            let secondView =  self.previousVC?.view
            
            let screenWidth = UIScreen.main.bounds.size.width
            let screenHeight = UIScreen.main.bounds.size.height
            
            secondView?.frame = CGRect(x: 0, y: -screenHeight, width: screenWidth, height: screenHeight)
            
            if let window = UIApplication.shared.keyWindow, let sv = secondView {
                window.insertSubview(sv, aboveSubview: self.view)
            }
            
            UIView.animate(withDuration: 1.5, animations: {
                firstView?.frame.origin.y += screenHeight
                secondView?.frame.origin.y += screenHeight
            })
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func tapToBack(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func swipeDownToBack(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
}
