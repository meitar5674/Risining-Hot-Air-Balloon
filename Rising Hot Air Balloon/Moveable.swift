//
//  Moveable.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class Moveable: SKSpriteNode {
    
    static let RESET_Y_POS: CGFloat = -200
    static let START_Y_POS: CGFloat = GameScene.SCENE_HEIGHT
    
    var moveAction: SKAction!
    var moveForever: SKAction!
    
    func startMoving() {
        moveAction = SKAction.moveByX(0, y: GameManager.sharedInstance.MOVEMENT_SPEED, duration: 0.02)
        moveForever = SKAction.repeatActionForever(moveAction)
        
        self.runAction(moveForever)
    }
    
    override func update() {
        if self.position.y <= Moveable.RESET_Y_POS{
            didExceedBounds()
        }
    }
    
    func didExceedBounds() {
        let randomX = CGFloat(arc4random_uniform(UInt32(GameScene.SCENE_WIDTH) - 700) + UInt32(GameScene.SCENE_WIDTH / 3.5))
        self.position = CGPointMake(randomX, 768)
    }
    
}