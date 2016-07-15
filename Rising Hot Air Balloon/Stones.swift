//
//  Stones.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class Stones: Moveable {
    
    var resetY: CGFloat = -200
    
    convenience init() {
        let random = arc4random_uniform(2) + 1
        self.init(imageNamed: "rock\(random)")
        self.anchorPoint = CGPointMake(0.5, 0)
        self.size.width = GameScene.SCENE_WIDTH / 30
        self.size.height = GameScene.SCENE_HEIGHT / 24
        self.zPosition = 6
        colliders()
    }
    
    
    override func startMoving() {
        let randomX = CGFloat(arc4random_uniform(UInt32(GameScene.SCENE_WIDTH) - 700) + UInt32(GameScene.SCENE_WIDTH / 3.5))
        print("Stone: \(randomX)")
        self.position = CGPointMake(randomX, 768)
        super.startMoving()
        update()
    }
    
    func colliders() {
        let bottomCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width * 0.8, 5), center: CGPointMake(-(self.size.width / 2) + 20, 0))
        bottomCollider.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        bottomCollider.categoryBitMask = GameManager.sharedInstance.COLLIDER_ROCK
        self.physicsBody = bottomCollider
        self.physicsBody?.dynamic = false
    }
    
    override func update() {
        if self.position.y <= resetY {
            if resetY < -100 {
                resetY += 2
                print("resetY: \(resetY)")
            }
            didExceedBounds()
        }
    }
    
}
