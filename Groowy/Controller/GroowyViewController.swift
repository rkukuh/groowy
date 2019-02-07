//
//  GroowyViewController.swift
//  Groowy
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit

class GroowyViewController: UIViewController {

    @IBOutlet weak var spriteKitView:SKView!
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.presentScene(scene)
    }
    
    @IBAction func tapToWakeGroowy(sender:UITapGestureRecognizer) {
        scene.groowyCharacter.changeGroowyAnimateState(nextState: .wake)
    }

}
