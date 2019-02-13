//
//  GiftViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/10/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit
import MessageUI

class GiftViewController: UIViewController, MFMailComposeViewControllerDelegate, UIGiftViewDelegate{
    
    func clickedBoxGift(text: String) {
        
        print("halo")
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            //present(mail,animated: true, completion: nil)
            //present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    var textFieldInput: UICustomTextViewView?
    var giftBox: UIGiftView?
    var scene: GameScene!
    var timer:Timer!
    
    @IBOutlet weak var spriteKit: SKView!
    @IBOutlet weak var handBottomView: UIView!
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        spriteKit.ignoresSiblingOrder = true
        spriteKit.presentScene(scene)
        textFieldInput = UICustomTextViewView(view: view)
        giftBox = UIGiftView(view: view)
        
        if let myGift = giftBox {
            myGift.customDelegate = self
            view.addSubview(myGift)
            view.bringSubviewToFront(handBottomView)
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        giftBox!.startAnimationSelf()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6, execute: {
            if let myText = self.textFieldInput {
                self.view.addSubview(myText)
                myText.startAnimationSelf()
            }
        })
        
        //textFieldInput!.startAnimationSelf()
        scene.groowyCharacter.changeGroowyAnimateState(nextState: .wake)
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
