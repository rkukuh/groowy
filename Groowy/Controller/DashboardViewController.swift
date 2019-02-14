//
//  DashboardViewController.swift
//  Groowy
//
//  Created by David-UC on 2/14/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var spriteKitView:SKView!
    
    var scene: GameScene!
    var bubbleChat:UICustomTextViewView?
    

    override func viewDidLoad() {
        
        setupGameScene()
        setupBubbleChat()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bubbleChat?.startAnimationSelf()
    }
    
    // MARK: - Setup
    
    func setupGameScene() {
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.presentScene(scene)
        
        scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
    }
    
    func setupBubbleChat() {
        // Add Bubble Chat
        bubbleChat = UICustomTextViewView(view: view)
        if let myText = bubbleChat{
            self.view.addSubview(myText)
        }
        bubbleChat?.isHidden = true
        
    }
}
