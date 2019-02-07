//
//  GameScene.swift
//  Groowy
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    // Groowy properties
    let groowyCharacter = GroowyCharacter()
    
    // Call first when scene loaded in View Controller
    override func sceneDidLoad() {
        backgroundColor = COLOR_THEME_PRIMARY
        setupGroowy()
    }
    
    func setupGroowy() {
        let size = CGSize(width: frame.width, height: frame.width)
        let position = CGPoint(x: frame.midX, y: frame.midY)
        
        groowyCharacter.build(initState: .sleep, size: size, position: position, scene: self)
        groowyCharacter.startAnimate()
    }
}
