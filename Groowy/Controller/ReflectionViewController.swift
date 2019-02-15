//
//  GroowyViewController.swift
//  Groowy
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


class ReflectionViewController: UIViewController, UITextFieldInputAccessoryViewDelegate {
    
    var reflectionStart = false
    var scene: GameScene!
    var timer: Timer!
    var bubbleChat: UICustomTextViewView?
    var textFieldInput: UITextFieldInputAccessoryView?
    let textField = UITextField(frame: CGRect(x: 0, y: -50, width: 100, height: 50))
    
    
    var expressions = [
        "😣","😔","😥","☹️","😕","😐","🙂","🧐","😏","😎","🤯"
    ]
    var expressionsText = [
        "Frustate",
        "Disappointed",
        "Worry",
        "Sad",
        "Confused",
        "Nothing",
        "Happy",
        "Curious",
        "Confident",
        "Awesome",
        "Mind-blown"
    ]
    var negativeExpressionReactionsText = [
        "It's okay to be $feeling, at least you had learn something today and it was awesome!"
    ]
    var positiveExpressionReactionsText = [
        "Awesome!"
    ]
    
    var lastExpression = ""
    
    @IBOutlet weak var expressionView: UIView!
    @IBOutlet weak var expressionLabel: UILabel!
    @IBOutlet weak var expressionTextLabel: UILabel!
    @IBOutlet weak var spriteKitView: SKView!
    @IBOutlet weak var bottomView: UIAnswerBodyView!
    @IBOutlet weak var bottomHandLayoutConstraint: NSLayoutConstraint!
    
    var reflectionDialog = DialogRule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = COLOR_THEME_PRIMARY
        setupHiddenTextField()
        setupGameScene()
        setupBubbleChat()
        initBubbleChat()
        setupBottomView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bubbleChat?.startAnimationSelf()
        GroowieSound.changeSoundEffectRepeat(sound: .smile)
        GroowieSound.startBackSound()
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
        
        scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
        stayAwake()
    }
    
    
    func setupExpression() {
        lastExpression = expressionsText[5]
        expressionLabel.text = expressions[5]
        expressionTextLabel.text = expressionsText[5]
    }
    func setupBubbleChat() {
        // Add Bubble Chat
        bubbleChat = UICustomTextViewView(view: view)
        
        if let myText = bubbleChat{
            self.view.addSubview(myText)
        }
    }
    
    func initBubbleChat() {
        let name = User.name
        bubbleChat?.messageTextView.text = "Hi, \(name). It's a good time to reflect your last challenge!"
    }
    
    func setupBottomView() {
        bottomView.topButton.addTarget(self, action: #selector(actionButtonTop), for: .touchUpInside)
        bottomView.bottomButton.addTarget(self, action: #selector(actionButtonBottom), for: .touchUpInside)
        
        bottomView.isHidden = true
        
        bottomView.topButton.setTitle("Mentor", for: .normal)
        bottomView.bottomButton.setTitle("Mentee", for: .normal)
    }
    
    
    // MARK: - Action buttons & sliders
    @IBAction func didChangeFeelingSlider(sender: UISlider) {
        let valueInInt = Int(sender.value)
        expressionLabel.text = expressions[valueInInt]
        expressionTextLabel.text = expressionsText[valueInInt]
        
        if lastExpression != expressionsText[valueInInt] {
            // Haptic Feedback
            UISelectionFeedbackGenerator().selectionChanged()
        }
        lastExpression = expressionsText[valueInInt]
        
    }
    
    @objc func actionButtonTop(_sender: UIButton){
        User.role = UserRole.mentor.rawValue
    }
    
    @objc func actionButtonBottom(_sender: UIButton){
        User.role = UserRole.mentee.rawValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Haptic Feedback
        UISelectionFeedbackGenerator().selectionChanged()
        
        if !reflectionStart {
             bubbleChat?.messageTextView.text = "Tell me how do you feel?"
            expressionView.isHidden = false
        }
    }
    
    func stayAwake() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 1...3), repeats: false, block: { (timer) in
            GroowieSound.changeSoundEffect(sound: .blink)
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
        // Dismiss keyboard, need to refine
        if let textFieldInput = textFieldInput {
            let name = textFieldInput.textField.text
            User.name = name ?? ""
            textFieldInput.resignFirstResponder()
            view.endEditing(true)
        }
        
        bottomView.isHidden = false
        
    }
}
