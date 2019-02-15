//
//  QuestionViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit
import MessageUI

class DialogViewController: UIViewController {
    
    var currentDialog = DialogState()
    var textFieldInput: UICustomTextViewView?
    var deepUnderstandingDialog = DialogRule()
    
    @IBOutlet weak var bottomView: UIAnswerBodyView!
    @IBOutlet weak var spriteKitView: SKView!
    
    var scene: GameScene!
    var timer:Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.presentScene(scene)
        textFieldInput = UICustomTextViewView(view: view)
        loadDialogData()
        setupCurrentDialog()
        
        bottomView.topButton.addTarget(self, action: #selector(actionButtonTop), for: .touchUpInside)
        bottomView.bottomButton.addTarget(self, action: #selector(actionButtonBottom), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textFieldInput!.startAnimationSelf()
        scene.groowyCharacter.changeGroowyAnimateState(nextState: .wake)
        stayAwake()
    }
    // MARK: - Action buttons
    @objc func actionButtonTop(_sender: UIButton){
        if currentDialog.nextState(answerIndex: 0) == true{
            updateDialog()
        }else{
            bottomView.bottomButton.isHidden = true
            bottomView.topButton.isHidden = true
            updateDialog()
            bottomView.removeFromSuperview()
            bottomView = nil
        }
    }
    
    @objc func actionButtonBottom(_sender: UIButton){
        if currentDialog.nextState(answerIndex: 1) == true{
            updateDialog()
        }else{
            bottomView.bottomButton.isHidden = true
            bottomView.topButton.isHidden = true
            updateDialog()
            bottomView.removeFromSuperview()
            bottomView = nil
        }
    }
    
    func stayAwake() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 1...3), repeats: false, block: { (timer) in
            self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .wake)
            self.stayAwake()
            
        })
    }
    
    // MARK: - Private functions
    
    private func loadDialogData() {
        deepUnderstandingDialog.category = "Deep Understanding dialog"
        
        let dialogs = [
            Dialog("Are you ready to take challenges in this Academy?"),
            Dialog("Why? Are you going to avoid a challenge?"),
            Dialog("Don't you want to even try?"),
            Dialog("Great! We should face the challenge and not giving up easily, aren't we?"),
            Dialog("Why? How do you see an effort as?"),
            Dialog("Don't you want to be successful? Don't you know it takes an effort?"),
            Dialog("How you can be successful if you never give a try?"),
            Dialog("Well, that's for your sake. Try to accept a critic as an improvement"),
            Dialog("Great! That's the right mindset that you have"),
        ]
        
        deepUnderstandingDialog.dialogs.append(contentsOf: dialogs)
        
        deepUnderstandingDialog.dialogs[0].answers.append(DialogAnswer("Sure!", then: deepUnderstandingDialog.dialogs[2]))
        deepUnderstandingDialog.dialogs[0].answers.append(DialogAnswer("Not Sure", then: deepUnderstandingDialog.dialogs[1]))
        
        deepUnderstandingDialog.dialogs[1].answers.append(DialogAnswer("No", then: deepUnderstandingDialog.dialogs[3]))
        deepUnderstandingDialog.dialogs[1].answers.append(DialogAnswer("Yes", then: deepUnderstandingDialog.dialogs[2]))
        
        deepUnderstandingDialog.dialogs[2].answers.append(DialogAnswer("Yes", then: deepUnderstandingDialog.dialogs[3]))
        deepUnderstandingDialog.dialogs[2].answers.append(DialogAnswer("I'll Try", then: deepUnderstandingDialog.dialogs[3]))
        
        deepUnderstandingDialog.dialogs[3].answers.append(DialogAnswer("Sure", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[3].answers.append(DialogAnswer("Not sure", then: deepUnderstandingDialog.dialogs[4]))
        
        deepUnderstandingDialog.dialogs[4].answers.append(DialogAnswer("The Path to Mastery", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[4].answers.append(DialogAnswer("Fruitless", then: deepUnderstandingDialog.dialogs[5]))
        
        deepUnderstandingDialog.dialogs[5].answers.append(DialogAnswer("OK, Sure", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[5].answers.append(DialogAnswer("Not Really", then: deepUnderstandingDialog.dialogs[6]))
        
        deepUnderstandingDialog.dialogs[6].answers.append(DialogAnswer("You are right. I got it", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[6].answers.append(DialogAnswer("Still No...", then: deepUnderstandingDialog.dialogs[7]))
        
        deepUnderstandingDialog.dialogs[7].answers.append(DialogAnswer("You are right. I got it", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[7].answers.append(DialogAnswer("Yeah, I guess I got your point", then: deepUnderstandingDialog.dialogs[8]))
        
        deepUnderstandingDialog.dialogs[8].answers.append(DialogAnswer("", then: nil))
        deepUnderstandingDialog.dialogs[8].answers.append(DialogAnswer("", then: nil))
        
        currentDialog.current = deepUnderstandingDialog.dialogs[0]
        currentDialog.history = []
    }
    
    private func setupCurrentDialog() {
        currentDialog.current = deepUnderstandingDialog.dialogs[0]
        updateDialog()
    }
    
    private func updateDialog() {
        
        if let currentDialog = currentDialog.current {
            if let myText = textFieldInput {
                view.addSubview(myText)
                
                textFieldInput!.messageTextView.text = currentDialog.text
            }
            
            if currentDialog.answers.count > 0 {
                bottomView.topButton.setTitle(currentDialog.answers[0].text, for: .normal)
            }
            
            if currentDialog.answers.count > 1 {
                bottomView.bottomButton.setTitle(currentDialog.answers[1].text, for: .normal)
            }
        }
    }
}
