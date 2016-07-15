//
//  Player.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class Player: Moveable {
    
    var charLoseAnimation = [SKTexture]()
    
    let CHAR_X_POS = GameScene.SCENE_WIDTH / 2
    let CHAR_Y_POS: CGFloat = 50
    
    var gameOver = false
    var gameOverAnimation = [SKTexture]()
    var gameWasDone = false
    
    
    
    convenience init() {
        self.init(imageNamed: "Hot Air Baloon")
        self.anchorPoint = CGPointMake(0.5, 0)
        self.size.width = GameScene.SCENE_WIDTH / 12
        self.size.height = GameScene.SCENE_HEIGHT / 6
        setupCharacter()
    }
    
    func setupCharacter() {
        for x in 1...5 {
            charLoseAnimation.append(SKTexture(imageNamed: "baloon fading \(x)"))
        }
        self.position = CGPointMake(CHAR_X_POS, CHAR_Y_POS)
        self.zPosition = 10
        
        let leftColliderSize = CGSizeMake(5, self.size.height)
        let leftCollider = SKPhysicsBody(rectangleOfSize: leftColliderSize, center: CGPointMake(-self.size.width / 2 + 5, self.size.height))
        
        let bottomColliderSize = CGSizeMake(self.size.width , 5)
        let bottomCollider = SKPhysicsBody(rectangleOfSize: bottomColliderSize, center: CGPointMake(-self.size.width / 2, 0))
        
        let rightColliderSize = (CGSizeMake(5, self.size.height))
        let rightCollider = SKPhysicsBody(rectangleOfSize: rightColliderSize, center: CGPointMake(self.size.width / 2 - 5, self.size.height))
        
        self.physicsBody = SKPhysicsBody(bodies: [leftCollider, bottomCollider, rightCollider])
        self.name = "meitar"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.restitution = 0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.linearDamping = 0.1
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0.02
        self.physicsBody?.dynamic = true
        
        
        
        self.physicsBody?.categoryBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        self.physicsBody?.contactTestBitMask = GameManager.sharedInstance.COLLIDER_ROCK
        
    }
    
    func setImage() {
        self.texture = SKTexture(imageNamed: "Hot Air Baloon Fire")
    }
    
    func lostAnimation() {
        setLoseAnimation()
        self.removeAllActions()
        self.runAction(SKAction.animateWithTextures(gameOverAnimation, timePerFrame: 0.08))
        
    }
    
    func setLoseAnimation() {
        print(self.size.width)
        for x in 1...5 {
            gameOverAnimation.append(SKTexture(imageNamed: "baloon fading \(x)"))
        }
    }
    
    func outFromTheRightSide() {
        if (self.position.x - self.size.width / 2) > GameScene.SCENE_WIDTH - 305 {
            self.position.x = self.size.width + 175
        }
    }
    
    func outFromTheLeftSide() {
        if self.position.x < self.size.width + 165 {
            print("bannanananana")
            self.position.x = GameScene.SCENE_WIDTH - 310
                + self.size.width / 2
        }
    }
    
    
    
    override func update() {
        outFromTheLeftSide()
        outFromTheRightSide()
        if gameOver && !gameWasDone{
            gameWasDone = true
            lostAnimation()
            self.startMoving()
        }// if collids so stop game
    }
    
    
    
    
}