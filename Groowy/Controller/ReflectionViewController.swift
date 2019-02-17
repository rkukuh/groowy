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

enum ReflectionState {
    case didNotStart
    case askFeeling
    case confirmFeeling
    case reactFeeling
    case askLearn
    case askQuestion
    case takeAPhoto
    case reChallenge
    case advise
    case promise
}

class ReflectionViewController: UIViewController, UITextViewInputAccessoryViewDelegate {
    
    var currentReflectionState = ReflectionState.didNotStart
    var scene: GameScene!
    var timer: Timer!
    var bubbleChat: UICustomTextViewView?
    var textFieldInput: UITextViewInputAccessoryView?
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
    
    var lastExpressionValue = 5
    var lastExpression = ""
    var isAboutToConfirmFelling = false
    
    @IBOutlet weak var expressionView: UIView!
    @IBOutlet weak var expressionLabel: UILabel!
    @IBOutlet weak var expressionTextLabel: UILabel!
    @IBOutlet weak var spriteKitView: SKView!
    @IBOutlet weak var bottomView: UIAnswerBodyView!
    @IBOutlet weak var bottomHandLayoutConstraint: NSLayoutConstraint!
    
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
        lastExpressionValue = 5
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
        
        bottomView.topButton.setTitle("Yes", for: .normal)
        bottomView.bottomButton.setTitle("No", for: .normal)
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
        lastExpressionValue = valueInInt
        
        isAboutToConfirmFelling = true
    }
    
    @IBAction func didEndFeelingSlider(sender: UISlider) {
        if isAboutToConfirmFelling {
            isAboutToConfirmFelling = false
            currentReflectionState = .confirmFeeling
            updateReflectionState()
        }
    }
    
    @objc func actionButtonTop(_sender: UIButton){
        if currentReflectionState == .confirmFeeling {
            // YES
            currentReflectionState = .reactFeeling
            updateReflectionState()
        } else if currentReflectionState == .reactFeeling {
            currentReflectionState = .askLearn
            updateReflectionState()
        } else if currentReflectionState == .takeAPhoto {
            currentReflectionState = .reChallenge
            updateReflectionState()
        } else if currentReflectionState == .advise {
            currentReflectionState = .promise
            updateReflectionState()
        } else if currentReflectionState == .reChallenge {
            currentReflectionState = .promise
            updateReflectionState()
        }
    }
    
    @objc func actionButtonBottom(_sender: UIButton){
        if currentReflectionState == .confirmFeeling {
            // NO
            currentReflectionState = .askFeeling
            updateReflectionState()
        } else if currentReflectionState == .reactFeeling {
            currentReflectionState = .askFeeling
            updateReflectionState()
        } else if currentReflectionState == .takeAPhoto {
            takeAPhoto()
        } else if currentReflectionState == .reChallenge {
            currentReflectionState = .advise
            updateReflectionState()
        } else if currentReflectionState == .advise {
            currentReflectionState = .promise
            updateReflectionState()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Haptic Feedback
        UISelectionFeedbackGenerator().selectionChanged()
        
        if currentReflectionState == .didNotStart {
            currentReflectionState = .askFeeling
            updateReflectionState()
        }
    }
    
    func stayAwake() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 1...3), repeats: false, block: { (timer) in
            GroowieSound.changeSoundEffect(sound: .blink)
            self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
            self.stayAwake()
        })
    }
    
    func updateReflectionState() {
        if currentReflectionState == .askFeeling {
            bubbleChat?.messageTextView.text = "Tell me how do you feel?"
            expressionView.isHidden = false
        } else if currentReflectionState == .confirmFeeling {
            bubbleChat?.messageTextView.text = "Hmm, are you feeling \(lastExpression.lowercased())?"
            expressionView.isHidden = true
            bottomView.topButton.setTitle("Yes", for: .normal)
            bottomView.bottomButton.setTitle("No", for: .normal)
            bottomView.isHidden = false
        } else if currentReflectionState == .reactFeeling {
            if lastExpressionValue == 5 {
                currentReflectionState = .askLearn
                updateReflectionState()
            } else if lastExpressionValue > 5 {
                let randomIndex = Int.random(in: 0..<positiveExpressionReactionsText.count)
                bubbleChat?.messageTextView.text = positiveExpressionReactionsText[randomIndex].replacingOccurrences(of: "$feeling", with: lastExpression.lowercased())
                
                bottomView.topButton.setTitle("Absolutely!", for: .normal)
                bottomView.bottomButton.setTitle("I want to change my feeling", for: .normal)
            } else {
                let randomIndex = Int.random(in: 0..<negativeExpressionReactionsText.count)
                bubbleChat?.messageTextView.text = negativeExpressionReactionsText[randomIndex].replacingOccurrences(of: "$feeling", with: lastExpression.lowercased())
                
                bottomView.topButton.setTitle("Thanks for cheer me up!", for: .normal)
                bottomView.bottomButton.setTitle("I want to change my feeling", for: .normal)
            }
        } else if currentReflectionState == .askLearn {
            bubbleChat?.messageTextView.text = "What did you learn?"
            showKeyboardWithTextViewAccessoryView()
        } else if currentReflectionState == .askQuestion {
            bubbleChat?.messageTextView.text = "What questions are still bother you?"
            resetTextView()
        } else if currentReflectionState == .takeAPhoto {
            bubbleChat?.messageTextView.text = "Great progress with great memory, take a photo to help you memorize"
            dismissKeyboard()
            
            bottomView.topButton.setTitle("Take a photo", for: .normal)
            bottomView.bottomButton.setTitle("I don't want to take a photo", for: .normal)
        } else if currentReflectionState == .reChallenge {
            bubbleChat?.messageTextView.text = "Are you want to take a challenge tomorrow?"
            
            bottomView.topButton.setTitle("Sure", for: .normal)
            bottomView.bottomButton.setTitle("Nope", for: .normal)
        } else if currentReflectionState == .advise {
            bubbleChat?.messageTextView.text = "I suggest you to keep learning by taking many challenges every day"
            
            
            bottomView.topButton.setTitle("OK, I'll take it tomorrow", for: .normal)
            bottomView.bottomButton.setTitle("I think I got your point", for: .normal)
        }
    }
    
    func showKeyboardWithTextViewAccessoryView() {
        if let textFieldInput = loadViewFromNib(nibName: "UITextViewInputAccessoryView") as? UITextViewInputAccessoryView {
            self.textFieldInput = textFieldInput
            
            textField.autocorrectionType = .no
            textFieldInput.textView.autocapitalizationType = .sentences
            textField.inputAccessoryView = textFieldInput
            
            textField.becomeFirstResponder()
            
            textFieldInput.delegate = self
        }
    }
    
    func resetTextView() {
        if let textViewWithPlaceholder = self.textFieldInput?.textView as? UITextViewWithPlaceholder {
            textViewWithPlaceholder.placeholderTextView.text = "What actions do motivated me as a learner?"
        }
        self.textFieldInput?.clear()
    }
    
    func didTapSendButton() {
        
        if let textFieldInput = textFieldInput {
            let content = textFieldInput.textView.text
            
            // Get content from User
            if currentReflectionState == .askLearn {
                print("Learn : \(content)")
                currentReflectionState = .askQuestion
                updateReflectionState()
            } else if currentReflectionState == .askQuestion {
                print("Question : \(content)")
                currentReflectionState = .takeAPhoto
                updateReflectionState()
            }
        }
        
        bottomView.isHidden = false
        
    }
    
    func dismissKeyboard() {
        textFieldInput?.resignFirstResponder()
        view.endEditing(true)
    }
    
    // TODO: JAYA
    func takeAPhoto() {
        
        
        //after you take a photo please call this function to update to next state
        currentReflectionState = .reChallenge
        updateReflectionState()
    }
    
    func doPromise() {
        
        
        //after you do promise you can dismiss the view controller
        self.dismiss(animated: false, completion: nil)
    }
}
