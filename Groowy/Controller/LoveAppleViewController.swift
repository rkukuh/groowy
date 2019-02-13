//
//  LoveAppleViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit

class LoveAppleViewController: UIViewController{
    var scene: GameScene!
    @IBOutlet weak var eyeSKView: SKView!
    @IBOutlet var mainView: UIView!
    
    var textFieldInput: UICustomTextViewView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        eyeSKView.ignoresSiblingOrder = true
        eyeSKView.presentScene(scene)
        scene.groowyCharacter.changeGroowyAnimateState(nextState: .wake)
        textFieldInput = UICustomTextViewView(view: mainView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textFieldInput!.startAnimationSelf()
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
