//
//  DetailJournalViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/15/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit

class DetailJournalViewController: UIViewController {
    @IBOutlet weak var spriteKitView: SKView!
    var scene: GameScene!
    var timer: Timer!
    var challange:Challenge?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameScene()
        awake()
        // Do any additional setup after loading the view.
    }
    @IBAction func closeDetailJournal(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    func setupGameScene() {
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        scene.sceneDidLoad()
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.presentScene(scene)
    }
    
    func awake(){
        self.scene.groowyCharacter.setImagePosition(position: CGPoint(x: self.spriteKitView.frame.midX, y: self.spriteKitView.frame.midY + self.spriteKitView.frame.width / 2))
        self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
        self.stayAwake()
    }
    
    func stayAwake() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 1...3), repeats: false, block: { (timer) in
            GroowieSound.changeSoundEffect(sound: .blink)
            self.scene.groowyCharacter.setImagePosition(position: CGPoint(x: self.spriteKitView.frame.midX, y: self.spriteKitView.frame.midY + self.spriteKitView.frame.width / 2))
            self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
            self.stayAwake()
        })
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "embedDetailJournal"){
            if let detail = segue.destination as? DetailJournalTableViewController{
                detail.chalange = self.challange
            }
        }
    }
 

}
