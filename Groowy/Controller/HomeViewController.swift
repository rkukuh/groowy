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

    var timer: Timer!
    var scene: GameScene!
    var handStateDown = true
    var currentDialog = DialogState()
    var bubbleChat:UICustomTextViewView?
    var textFieldInput: UITextFieldInputAccessoryView?
    let textField = UITextField(frame: CGRect(x: 0, y: -50, width: 100, height: 50))
    
    @IBOutlet weak var spriteKitView:SKView!
    @IBOutlet weak var bottomView:UIAnswerBodyView!
    @IBOutlet weak var bottomHandLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHiddenTextField()
        setupGameScene()
        setupBubbleChat()
        setupBottomView()
        setupHand()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bubbleChat?.startAnimationSelf()
    }
    
    // MARK: - Setup
    
    func setupHiddenTextField() {
        // Add textfield outside of view
        view.addSubview(textField)
    }
    
    func setupGameScene() {
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.presentScene(scene)
    }
    
    func setupBubbleChat() {
        // Add Bubble Chat
        bubbleChat = UICustomTextViewView(view: view)
        
        if let myText = bubbleChat{
            self.view.addSubview(myText)
        }
        
        bubbleChat?.isHidden = true
    }
    
    func setupBottomView() {
        bottomView.topButton.addTarget(self, action: #selector(actionButtonTop), for: .touchUpInside)
        bottomView.bottomButton.addTarget(self, action: #selector(actionButtonBottom), for: .touchUpInside)
        
        bottomView.isHidden = true
        
        bottomView.topButton.setTitle("Mentor", for: .normal)
        bottomView.bottomButton.setTitle("Mentee", for: .normal)
    }
    
    func setupHand() {
        animateHand()
    }
    
    func animateHand() {
        if handStateDown {
            self.bottomHandLayoutConstraint.constant = 125
            UIView.animate(withDuration: 2, animations: {
                self.view.layoutIfNeeded()
            }) { (complete) in
                self.handStateDown = !self.handStateDown
                self.animateHand()
            }
        } else {
            self.bottomHandLayoutConstraint.constant = 150
            UIView.animate(withDuration: 2, animations: {
                self.view.layoutIfNeeded()
            }) { (complete) in
                self.handStateDown = !self.handStateDown
                self.animateHand()
            }
        }
    }
    
    // MARK: - Action buttons
    
    @objc func actionButtonTop(_sender: UIButton){
        User.role = UserRole.mentor.rawValue
    }
    
    @objc func actionButtonBottom(_sender: UIButton){
        User.role = UserRole.mentee.rawValue
    }
    
    @IBAction func tapToWakeGroowy(sender:UITapGestureRecognizer) {
        if scene.groowyCharacter.currentAnimationState == .sleep {
            scene.groowyCharacter.changeGroowyAnimateState(nextState: .halfAwake)
            bubbleChat?.messageTextView.text = "Hmm, who's there ?"

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.bubbleChat?.alpha = 0
                self.bubbleChat?.isHidden = false
                UIView.animate(withDuration: 0.5) {
                    self.bubbleChat?.alpha = 1
                }
            }
            
            // - START: Skip from WakeUp to Challenge -
            // let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            // let newViewController = storyBoard.instantiateViewController(withIdentifier: "create-challenge") as! TitleCreateChallengeViewController
            // self.present(newViewController, animated: false, completion: nil)
            // - FINISH: Skip from WakeUp to Challenge -
            
        } else if scene.groowyCharacter.currentAnimationState == .halfAwake {
            scene.groowyCharacter.changeGroowyAnimateState(nextState: .fullyAwake)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.bubbleChat?.messageTextView.text = "Oh Hi, My name is Groowy. What's your name ?"
                self.stayAwake()
                self.showKeyboardWithTextFieldAccessoryView()
            }
        }
    }
    
    func stayAwake() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 1...3), repeats: false, block: { (timer) in
            self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
            self.stayAwake()
        })
    }
    
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
