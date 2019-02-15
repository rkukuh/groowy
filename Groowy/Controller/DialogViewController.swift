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
    
    var isFinalState = false
    var currentDialog = DialogState()
    var textFieldInput: UICustomTextViewView?
    var deepUnderstandingDialog = DialogRule()
    
    @IBOutlet weak var tapToContinueLabel: UILabel!
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
        
        tapToContinueLabel.isHidden = true
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
            tapToContinueLabel.isHidden = false
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
            tapToContinueLabel.isHidden = false
            bottomView.bottomButton.isHidden = true
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
            Dialog("Congratulations! You are the choosen from many candidates out there to join this Academy"),
            Dialog("Before we started, I want to ask you some question..."),
            Dialog("Are you ready to take any challenges in this Academy?"),
            Dialog("Why? Do you mean to avoid challenges?"),
            Dialog("But at least, you want to try, aren't you?"),
            Dialog("Great! We should face it and never give up, right?"),
            Dialog("Why? How do you see an effort as?"),
            Dialog("Don't you want to make it happen? It will take much effort, isn't it?"),
            Dialog("How it is possible if you don't want to create any efforts?"),
            Dialog("I will give you this. Take any challenges and re-evaluate criticize as you do take a medicine"),
            Dialog("Great! I know why this Academy choose you. It's the right-mindset that you have"),
            Dialog("OK. Let's we start our Journey"),
        ]
        
        deepUnderstandingDialog.dialogs.append(contentsOf: dialogs)
        
        deepUnderstandingDialog.dialogs[0].answers.append(DialogAnswer("Yeah! 💪", then: deepUnderstandingDialog.dialogs[1]))
        deepUnderstandingDialog.dialogs[0].answers.append(DialogAnswer("Thank you 😆", then: deepUnderstandingDialog.dialogs[1]))
        
        deepUnderstandingDialog.dialogs[1].answers.append(DialogAnswer("OK", then: deepUnderstandingDialog.dialogs[2]))
        deepUnderstandingDialog.dialogs[1].answers.append(DialogAnswer("I hope it will be quick", then: deepUnderstandingDialog.dialogs[2]))
        
        deepUnderstandingDialog.dialogs[2].answers.append(DialogAnswer("Sure", then: deepUnderstandingDialog.dialogs[5]))
        deepUnderstandingDialog.dialogs[2].answers.append(DialogAnswer("I'm not sure", then: deepUnderstandingDialog.dialogs[3]))
        
        deepUnderstandingDialog.dialogs[3].answers.append(DialogAnswer("Nope", then: deepUnderstandingDialog.dialogs[5]))
        deepUnderstandingDialog.dialogs[3].answers.append(DialogAnswer("Yes", then: deepUnderstandingDialog.dialogs[4]))
        
        deepUnderstandingDialog.dialogs[4].answers.append(DialogAnswer("Yeah", then: deepUnderstandingDialog.dialogs[5]))
        deepUnderstandingDialog.dialogs[4].answers.append(DialogAnswer("I'll Try", then: deepUnderstandingDialog.dialogs[5]))
        
        deepUnderstandingDialog.dialogs[5].answers.append(DialogAnswer("Sure", then: deepUnderstandingDialog.dialogs[10]))
        deepUnderstandingDialog.dialogs[5].answers.append(DialogAnswer("Not sure", then: deepUnderstandingDialog.dialogs[6]))
        
        deepUnderstandingDialog.dialogs[6].answers.append(DialogAnswer("The path to mastery", then: deepUnderstandingDialog.dialogs[10]))
        deepUnderstandingDialog.dialogs[6].answers.append(DialogAnswer("Fruitless", then: deepUnderstandingDialog.dialogs[7]))
        
        deepUnderstandingDialog.dialogs[7].answers.append(DialogAnswer("Ok, sure", then: deepUnderstandingDialog.dialogs[10]))
        deepUnderstandingDialog.dialogs[7].answers.append(DialogAnswer("Not really", then: deepUnderstandingDialog.dialogs[8]))
        
        deepUnderstandingDialog.dialogs[8].answers.append(DialogAnswer("You are right. I got it", then: deepUnderstandingDialog.dialogs[10]))
        deepUnderstandingDialog.dialogs[8].answers.append(DialogAnswer("Still no...", then: deepUnderstandingDialog.dialogs[9]))
        
        deepUnderstandingDialog.dialogs[9].answers.append(DialogAnswer("You are right. I got it", then: deepUnderstandingDialog.dialogs[10]))
        deepUnderstandingDialog.dialogs[9].answers.append(DialogAnswer("Yeah, I guess I got your point", then: deepUnderstandingDialog.dialogs[10]))
        
        deepUnderstandingDialog.dialogs[10].answers.append(DialogAnswer("Of course!", then: deepUnderstandingDialog.dialogs[11]))
        deepUnderstandingDialog.dialogs[10].answers.append(DialogAnswer("OK", then: deepUnderstandingDialog.dialogs[11]))
        
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
            
            if currentDialog.text == "OK. Let's we start our Journey" {
                isFinalState = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isFinalState {
            User.state = UserState.dashboard.rawValue
            let storyBoard: UIStoryboard = UIStoryboard(name: "Jaya", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "gift") as! GiftViewController
            self.present(newViewController, animated: false, completion: nil)
        }
    }
}
