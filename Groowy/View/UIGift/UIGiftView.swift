//
//  UIGiftView.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/12/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class UIGiftView: UIView {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var imageGift: UIImageView!
    
    var animator:UIDynamicAnimator!
    var parentView:UIView!
    weak var customDelegate:UIGiftViewDelegate?

    @IBAction func clickedGiftBox(_ sender: UITapGestureRecognizer) {
        print("utana")
        customDelegate?.clickedBoxGift(text: "")
    }
    func setAnimator(view : UIView){
        animator = UIDynamicAnimator(referenceView: view)
    }
    
    func startAnimationSelf(){
        self.frame = CGRect(x: self.frame.minX, y: parentView.frame.maxY + self.frame.height / 2  , width: self.frame.width, height: self.frame.height)
        
        animator.removeAllBehaviors()
        self.alpha = 0
        // Animate in the overlay
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 1.0
        })
        // Animate the view using UIKit Dynamics.
        alpha = 1.0
        
        UIView.animate(withDuration: 1.6, animations: {
            self.frame = CGRect(x: self.frame.minX, y: self.parentView.frame.maxY - self.frame.height , width: self.frame.width, height: self.frame.height)
        })
        
        /*let snapBehaviour: UISnapBehavior = UISnapBehavior(item: self, snapTo: CGPoint(x: parentView.frame.midX, y: parentView.frame.maxY - self.frame.height / 2 ))
        snapBehaviour.damping = 1.0
        animator.addBehavior(snapBehaviour)*/
    }
    
    //Set by program custome
    init(view: UIView) {
        parentView = view
        let frame = CGRect(x: 0, y: view.frame.height , width: view.frame.width, height: view.frame.height * 0.5)
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
        Bundle.main.loadNibNamed("UIGift", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}

protocol UIGiftViewDelegate: class {
    func clickedBoxGift(text:String)
}
