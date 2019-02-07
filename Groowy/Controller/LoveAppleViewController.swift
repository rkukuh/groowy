//
//  LoveAppleViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit

class LoveAppleViewController: UIViewController , UIDynamicAnimatorDelegate{
    var scene: EyeSKScene!
    @IBOutlet weak var eyeSKView: SKView!
    @IBOutlet weak var messageDialogView: UIView!
    @IBOutlet weak var cobaText: UITextView!
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene = EyeSKScene(size: eyeSKView.bounds.size)
        scene.scaleMode = .resizeFill
        eyeSKView.ignoresSiblingOrder = true
        eyeSKView.presentScene(scene)
        
        
        let instantaneousPush: UIPushBehavior = UIPushBehavior(items: [messageDialogView], mode: UIPushBehavior.Mode.continuous)
        
        instantaneousPush.setAngle( CGFloat(Double.pi / 2) , magnitude: 0.3)
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.animator.addBehavior(instantaneousPush)
        animator.delegate = self
        //UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            
            
        //}, completion: nil)
        
        // Do any additional setup after loading the view.
    }
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
