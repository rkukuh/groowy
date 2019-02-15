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
    
    var isPlaying = false
    var scene: GameScene!
    var timer:Timer!
    var bubbleChat:UICustomTextViewView?
    

    override func viewDidLoad() {
        view.backgroundColor = COLOR_THEME_PRIMARY
        setupGameScene()
        setupBubbleChat()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bubbleChat?.startAnimationSelf()
        if !isPlaying {
            GroowieSound.changeBackSound(sound: .smile)
            GroowieSound.startBackSound()
            GroowieSound.startSoundEffect()
            isPlaying = true
        }
    }
    
    // MARK: - Setup
    
    func setupGameScene() {
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.presentScene(scene)
        
        scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
        stayAwake()
    }
    
    func setupBubbleChat() {
        // Add Bubble Chat
        bubbleChat = UICustomTextViewView(view: view)
        
        let name = User.name
        let greetings = [
            "Hi \(name), what do you want to do today?",
            "Don't decrease the goal, Increase the effort! Keep going, \(name)!",
            "Challenges are waht make life interesting, ready for the next challenge?",
            "Consistent effort is a consistent challenge, come on create a new challenge!"
        ]
        let randomGreeting = Int.random(in: 0..<greetings.count)
        bubbleChat?.messageTextView.text = greetings[randomGreeting]
        
        if let myText = bubbleChat{
            self.view.addSubview(myText)
        }
        
    }
    
    
    func stayAwake() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 1...3), repeats: false, block: { (timer) in
            GroowieSound.changeSoundEffect(sound: .blink)
            self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
            self.stayAwake()
            
        })
    }
    
    // MARK: - Action Buttons
    @IBAction func didTapTalkToGroowy(sender: UIButton) {
        
    }
    @IBAction func didTapTakeChallenge(sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "create-challenge") as! TitleCreateChallengeViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func didTapTheJournal(sender: UIButton) {
        
    }
    @IBAction func didTapSetting(sender: UIButton) {
        
    }
}
