//
//  GroowyViewController.swift
//  Groowy
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit

class HomeViewController: UIViewController, UITextFieldInputAccessoryViewDelegate {

    @IBOutlet weak var spriteKitView:SKView!
    var scene: GameScene!
    var timer:Timer!
    @IBOutlet weak var bottomView:UIAnswerBodyView!
    
    var bubbleChat:UICustomTextViewView?
    
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
        
        // Add Bubble Chat
        bubbleChat = UICustomTextViewView(view: view)
        if let myText = bubbleChat{
            self.view.addSubview(myText)
        }
        bubbleChat?.isHidden = true
        bubbleChat?.messageTextView.text = "Hi, I'm Groowy. What's your name ?"
        
        bottomView.topButton.addTarget(self, action: #selector(actionButtonTop), for: .touchUpInside)
        bottomView.bottomButton.addTarget(self, action: #selector(actionButtonBottom), for: .touchUpInside)
        
        bottomView.topButton.setTitle("Mentor", for: .normal)
        bottomView.bottomButton.setTitle("Mentee", for: .normal)
        bottomView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bubbleChat?.startAnimationSelf()
    }
    
    // MARK: - Action buttons
    
    @objc func actionButtonTop(_sender: UIButton){
        User.role = .mentor
    }
    
    @objc func actionButtonBottom(_sender: UIButton){
        User.role = .mentee
    }
    
    
    @IBAction func tapToWakeGroowy(sender:UITapGestureRecognizer) {
//        scene.groowyCharacter.changeGroowyAnimateState(nextState: .wake)
//        showKeyboardWithTextFieldAccessoryView()
//
//        stayAwake()
//
//        bubbleChat?.alpha = 0
//        bubbleChat?.isHidden = false
//        UIView.animate(withDuration: 0.5) {
//            self.bubbleChat?.alpha = 1
//        }
//
        let storyBoard: UIStoryboard = UIStoryboard(name: "Jaya", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "question") as! DialogViewController
        self.present(newViewController, animated: false, completion: nil)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Jaya", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gift") as! LoveAppleViewController
//        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    func stayAwake() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 1...3), repeats: false, block: { (timer) in
            self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
            self.stayAwake()
            
        })
    }
    
    var textFieldInput: UITextFieldInputAccessoryView?
    func showKeyboardWithTextFieldAccessoryView() {
        if let textFieldInput = loadViewFromNib(nibName: "UITextFieldInputAccessory") as? UITextFieldInputAccessoryView {
            self.textFieldInput = textFieldInput
            textField.autocorrectionType = .no
            textFieldInput.textField.autocapitalizationType = .words
            textField.inputAccessoryView = textFieldInput
            textField.becomeFirstResponder()
            textFieldInput.delegate = self
        }
        
    }
    
    func didTapSendButton() {
        if let textFieldInput = textFieldInput {
            let name = textFieldInput.textField.text
            User.name = name ?? ""
            textFieldInput.resignFirstResponder()
            view.endEditing(true)
        }
        bottomView.isHidden = false
        bubbleChat?.messageTextView.text = "Hi \(User.name) ! Are you a mentor / mentee ?"
        
    }

}

extension HomeViewController: UITextFieldDelegate {
    
}
