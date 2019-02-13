//
//  UICustomTextViewView.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class UICustomTextViewView: UIView {
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet var mainView: UIView!
    
    var animator:UIDynamicAnimator!
    var parentView:UIView!
    
    func setAnimator(view : UIView){
        animator = UIDynamicAnimator(referenceView: view)
    }
    
    func startAnimationSelf(){
        animator.removeAllBehaviors()
        // Animate in the overlay
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 1.0
        })
        // Animate the view using UIKit Dynamics.
        alpha = 1.0
        
        let snapBehaviour: UISnapBehavior = UISnapBehavior(item: self, snapTo: CGPoint(x: parentView.frame.midX, y: parentView.frame.minY + frame.height/2))
        snapBehaviour.damping = 1.0
        animator.addBehavior(snapBehaviour)
        
        
        frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        UIView.animate(withDuration: 1.0, delay: 1.0, options: [.repeat, .autoreverse], animations: {
            self.frame = CGRect(x: self.frame.minX, y: 5 , width: self.frame.width, height: self.frame.height)
            
        }, completion: nil)
    }
    
    //Set by program custome
    init(view: UIView) {
        parentView = view
        let frame = CGRect(x: 0, y: view.frame.height , width: view.frame.width, height: view.frame.height * 0.3)
        super.init(frame: frame)
        animator = UIDynamicAnimator(referenceView: view)
        commonInit()
    }
    
    //Set by program
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    //Set using storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("UICustomTextView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
