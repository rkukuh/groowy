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
    var timer:Timer!
    
    // Textfield
    let textField = UITextField(frame: CGRect(x: 0, y: -50, width: 100, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add textfield outside of view
        view.addSubview(textField)
        
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.presentScene(scene)
        
    }
    
    @IBAction func tapToWakeGroowy(sender:UITapGestureRecognizer) {
        /*scene.groowyCharacter.changeGroowyAnimateState(nextState: .wake)
        showKeyboardWithTextFieldAccessoryView()
        
        stayAwake()*/
        
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Jaya", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "question") as! QuestionViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    func stayAwake() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 1...3), repeats: false, block: { (timer) in
            self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .wake)
            self.stayAwake()
            
        })
    }
    
    func showKeyboardWithTextFieldAccessoryView() {
        let textFieldInput = loadViewFromNib(nibName: "UITextFieldInputAccessory") as! UITextFieldInputAccessoryView
        textField.autocorrectionType = .no
        textFieldInput.textField.autocapitalizationType = .words
        textField.inputAccessoryView = textFieldInput
        textField.becomeFirstResponder()
    }

}
