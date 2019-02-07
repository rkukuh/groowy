//
//  SpriteKitExtension.swift
//  Groowy
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    func loadTextureAtlas(atlasFilename:String,namingSeries:String) -> [SKTexture] {
        let atlas = SKTextureAtlas(named: atlasFilename)
        var frames: [SKTexture] = []
        
        let numImages = atlas.textureNames.count
        for i in 1...numImages {
            let imageName = "\(namingSeries)\(i)"
            frames.append(atlas.textureNamed(imageName))
        }
        return frames
    }
}
