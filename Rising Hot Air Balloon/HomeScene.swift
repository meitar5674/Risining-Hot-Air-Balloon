//
//  HomeScene.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class HomeScene: SKScene {
    
    var backGround: SKSpriteNode!
    
    var btnsArr = [SKSpriteNode]()
    
    var playBtn: SKSpriteNode!
    var aboutBtn: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var title: SKSpriteNode!
    var maker: SKSpriteNode!
    
    
    
    
    override func didMoveToView(view: SKView) {
        backGround = SKSpriteNode(imageNamed: "backGround")
        backGround.position = CGPointMake(self.size.width / 2 , self.size.height / 2)
        backGround.zPosition = 1
        self.addChild(backGround)
        setBtns()
        setTitle()
        setMaker()
        
        
    }
    
    override func update() {
        
    }
    
    func setMaker() {
        maker = SKSpriteNode(imageNamed: "maker")
        maker.position = CGPointMake(self.size.width / 2, title.position.y - 180)
        maker.zPosition = 5
        self.addChild(maker)
    }
    
    func setTitle() {
        title = SKSpriteNode(imageNamed: "Rising Baloon")
        title.position = CGPointMake(self.size.width / 2, self.size.height - 100)
        title.zPosition = 4
        self.addChild(title)
    }
    
    func setBtns(){
        playBtn = SKSpriteNode(imageNamed: "play")
        aboutBtn = SKSpriteNode(imageNamed: "About")
        if let score = NSUserDefaults.standardUserDefaults().valueForKey("score") as? Int {
            scoreLabel = SKLabelNode(text: "Highest Score: \(score)")
            scoreLabel.position = CGPointMake(self.size.width / 2, self.size.height / 2)
            scoreLabel.zPosition = 3
            self.addChild(scoreLabel)
        }
        
        btnsArr.append(playBtn)
        btnsArr.append(aboutBtn)
        
        
        for x in 0...1 {
            btnsArr[x].position = CGPointMake(self.size.width / 2, self.size.height / 2 - 70 * CGFloat(x + 1) - 50)
            btnsArr[x].zPosition = 2
            self.addChild(btnsArr[x])
        }
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if playBtn.containsPoint(location){
                goToGameScene()
            }else if aboutBtn.containsPoint(location){
                goToAboutScene()
            }
        }
        
    }
    
    func goToGameScene() {
        
        let transtion: SKTransition = SKTransition.fadeWithDuration(1)
        let scene: SKScene = GameScene(size: size)
        scene.scaleMode = .AspectFill
        
        self.view?.presentScene(scene, transition: transtion)
        
    }
    
    
    func goToAboutScene() {
        let transtion: SKTransition = SKTransition.fadeWithDuration(1)
        let scene: SKScene = AboutScene(size: size)
        scene.scaleMode = .AspectFill
        self.removeAllChildren()
        self.view?.presentScene(scene, transition: transtion)
    }
    
    
}