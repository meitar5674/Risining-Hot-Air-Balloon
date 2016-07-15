//
//  AboutScene.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class AboutScene: SKScene {
    
    var HomeBtn: SKSpriteNode!
    var backGround: SKSpriteNode!
    var desc: SKSpriteNode!
    var credit: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        backGround = SKSpriteNode(imageNamed: "backGround")
        backGround.position = CGPointMake(GameScene.SCENE_WIDTH / 2, GameScene.SCENE_HEIGHT / 2)
        backGround.zPosition = 1
        HomeBtn = SKSpriteNode(imageNamed: "HomePage")
        HomeBtn.position = CGPointMake(GameScene.SCENE_WIDTH / 2, GameScene.SCENE_HEIGHT - 200)
        HomeBtn.zPosition = 2
        self.addChild(HomeBtn)
        self.addChild(backGround)
        
        desc = SKSpriteNode(imageNamed: "desc")
        desc.position = CGPointMake(self.size.width / 2, HomeBtn.position.y - 150)
        desc.zPosition = 3
        self.addChild(desc)
        
        
        credit = SKSpriteNode(imageNamed: "credit")
        credit.position = CGPointMake(self.size.width / 2, desc.position.y - 200)
        credit.zPosition = 4
        self.addChild(credit)
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if HomeBtn.containsPoint(location){
                goToHomeScene()
            }
        }
        
    }
    
    
    func goToHomeScene() {
        let homeScene: HomeScene = HomeScene(size: self.size)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0)
        homeScene.scaleMode = SKSceneScaleMode.AspectFill
        self.removeAllChildren()
        self.view?.presentScene(homeScene, transition: transition)
    }
}