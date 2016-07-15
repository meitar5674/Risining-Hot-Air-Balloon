//
//  Clouds.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit


class Clouds: Moveable {
    convenience init() {
        let random = arc4random_uniform(8) + 1
        self.init(imageNamed: "cloud\(random)")
        self.anchorPoint = CGPointMake(0.5, 0.5)
        self.size.width = GameScene.SCENE_WIDTH / 12
        self.size.height = GameScene.SCENE_HEIGHT / 9
        self.zPosition = CGFloat(random) + 1
    }
    
    override func didExceedBounds() {
        super.didExceedBounds()
        self.texture = SKTexture(imageNamed: "cloud\(arc4random_uniform(8) + 1)")
    }
    
    override func startMoving() {
        let randomX = CGFloat(arc4random_uniform(UInt32(GameScene.SCENE_WIDTH) - 700) + UInt32(GameScene.SCENE_WIDTH / 3.5))
        print("Cloud: \(randomX)")
        self.position = CGPointMake(randomX, 768)
        super.startMoving()
    }
    
}