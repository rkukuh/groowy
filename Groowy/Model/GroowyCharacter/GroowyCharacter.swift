//
//  GroowyCharacter.swift
//  Groowy
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation
import SpriteKit
 
class GroowyCharacter {
    // MARK: Groowy properties
    var size:CGSize!
    var position:CGPoint!
    private var groowySprite = SKSpriteNode()
    var currentAnimationState:GroowyAnimationState = .sleep
    private var actions:[GroowyAnimationState: SKAction] = [:]
    private var firstFrameTexture: SKTexture!
    
    // MARK: Groowy Public Functions
    func build(initState:GroowyAnimationState, size:CGSize, position:CGPoint, scene:SKScene) {
        self.size = size
        self.position = position
        currentAnimationState = initState
        buildGroowySleep()
        buildGroowyWake()
        buildGroowyAwake()
        buildGroowyAsleep()
        addToView(scene: scene)
    }
    
    func startAnimate() {
        animateGroowyState()
    }
    
    func stopAnimate() {
        groowySprite.removeAllActions()
    }
    
    func changeGroowyAnimateState(nextState:GroowyAnimationState) {
        currentAnimationState = nextState
        animateGroowyState()
    }
    
    // MARK: Groowy Private Functions
    
    private func addToView(scene:SKScene) {
        scene.addChild(groowySprite)
    }
    
    private func initSpriteNode(texture:SKTexture) {
        groowySprite = SKSpriteNode(texture: texture)
        groowySprite.size = size
        groowySprite.position = position
    }
    
    // Function to generate groowy sleep animation using SKTextureAtlas
    private func buildGroowySleep() {
        let sleepFrames = groowySprite.loadTextureAtlas(atlasFilename: GroowyAnimationState.sleep.rawValue, namingSeries: "")
        if currentAnimationState == .sleep {
            initSpriteNode(texture: sleepFrames[0])
        }
        
        actions[.sleep] = SKAction.repeatForever(SKAction.animate(with: sleepFrames, timePerFrame: 1.0/8.0, resize: false, restore: true))
    }
    
    // Function to generate groowy wake animation using SKTextureAtlas
    private func buildGroowyWake() {
        let wakeFrames = groowySprite.loadTextureAtlas(atlasFilename: GroowyAnimationState.wake.rawValue, namingSeries: "")
        if currentAnimationState == .wake {
            initSpriteNode(texture: wakeFrames[0])
        }
        actions[.wake] = SKAction.animate(with: wakeFrames, timePerFrame: 1.5)
    }
    
    private func buildGroowyAwake() {
        let wakeFrames = groowySprite.loadTextureAtlas(atlasFilename: GroowyAnimationState.wake.rawValue, namingSeries: "")
        if currentAnimationState == .wake {
            initSpriteNode(texture: wakeFrames[0])
        }
        actions[.awake] = SKAction.animate(with: wakeFrames, timePerFrame: 1.0/8.0)
    }
    
    // Function to generate groowy asleep animation using SKTextureAtlas
    private func buildGroowyAsleep() {
        let asleepFrames = groowySprite.loadTextureAtlas(atlasFilename: GroowyAnimationState.asleep.rawValue, namingSeries: "")
        if currentAnimationState == .asleep {
            initSpriteNode(texture: asleepFrames[0])
        }
        actions[.asleep] = SKAction.animate(with: asleepFrames, timePerFrame: 1.0/8.0)
    }
    
    // Function to animate groowy state
    private func animateGroowyState() {
        if currentAnimationState == .sleep, let sleepAnimation = actions[.sleep] {
            groowySprite.removeAllActions()
            groowySprite.run(sleepAnimation)
            print("sleep")
        } else if currentAnimationState == .wake, let wakeAnimation = actions[.wake] {
            groowySprite.removeAllActions()
            groowySprite.run(wakeAnimation)
            print("wake")
        } else if currentAnimationState == .awake, let awakeAnimation = actions[.awake] {
            groowySprite.removeAllActions()
            groowySprite.run(awakeAnimation)
            print("awake")
        } else if currentAnimationState == .asleep, let asleepAnimation = actions[.asleep], let sleepAnimation = actions[.sleep]  {
            groowySprite.removeAllActions()
            groowySprite.run(asleepAnimation) {
                self.groowySprite.run(sleepAnimation)
            }
        }
    }
}

