//
//  GameScene.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright (c) 2016 meitar. All rights reserved.
//

import SpriteKit
import CoreMotion
import AVFoundation


class GameScene: SKScene,SKPhysicsContactDelegate {
    
    static let SCENE_WIDTH: CGFloat = 1024
    static let SCENE_HEIGHT: CGFloat = 768
    static let FRAMES_PER_UPDATE = 10
    
    let MAX_ACCELERATION = 0.1
    let MIN_ACCELERATION = -0.1
    
    let playerName = "meitar"
    
    // Screen Setup
    var ground: Ground!
    var player: Player!
    //
    var baloon: SKSpriteNode!
    var bottom: SKSpriteNode!
    var backGround: SKSpriteNode!
    var clouds = [SKSpriteNode]()
    var rockArr = [SKSpriteNode]()
    var moveGroundAction: SKAction!
    var moveGroundActionForever: SKAction!
    
    
    // Score Setup
    var score = 0
    var countFrames = 0
    var scoreLabel: SKLabelNode!
    //
    
    // Btns
    var btnsAppear = false
    var playAgainBtn: SKSpriteNode!
    var homePageBtn: SKSpriteNode!
    //
    
    // Move Ditactor
    var motionManager = CMMotionManager()
    var destX: CGFloat = 0.0
    //
    
    // Timer
    var rockTimer: NSTimer!
    //
    
    
    // Stones
    var stoneTwo = false
    var stoneThree = false
    var stoneFour = false
    //
    
    
    //
    var musicPlayer: AVAudioPlayer!
    //
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        setScreen()
        motionManager.startAccelerometerUpdates()
        //  baloonMotion()
        playLevelMusic()
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        for child in self.children {
            child.update()
            if !player.gameOver {
                countFrames += 1
                if countFrames == GameScene.FRAMES_PER_UPDATE {
                    score += 1
                    scoreLabel.text = "Score \(score)"
                    countFrames = 0
                }
            }
        }
        
        if score > 500 {
            if !stoneTwo{
                stoneTwo = true
                addRock()
            }else if score > 1000{
                if !stoneThree{
                    stoneThree = true
                    addRock()
                }else if score > 2000{
                    if !stoneFour{
                        stoneFour = true
                        addRock()
                    }
                }
            }
        }
        
        processUserMotionForUpdate(currentTime)
        
        
    }
    
    func fallingRocks(){
        let wait = SKAction.waitForDuration(2)
        self.runAction(wait, completion: { () -> Void in
            let stone = Stones()
            self.rockArr.append(stone)
            self.addChild(stone)
            stone.startMoving()
        })
        
    }
    
    func setPlayer() {
        player = Player()
        self.addChild(player)
    }
    
    func setScoreLabel() {
        scoreLabel.position = CGPointMake(GameScene.SCENE_WIDTH / 2 , GameScene.SCENE_HEIGHT / 2)
        scoreLabel.zPosition = 10
    }
    
    func setBackGround() {
        backGround = SKSpriteNode(imageNamed: "backGround")
        backGround.position = CGPointMake(self.size.width / 2 , self.size.height / 2)
        backGround.zPosition = 1
        self.addChild(backGround)
    }
    
    func setGround() {
        bottom = Ground()
        self.addChild(bottom)
    }
    
    func setBtns() {
        
        playAgainBtn = SKSpriteNode(imageNamed: "playAgain")
        playAgainBtn.position = CGPointMake(self.size.width / 2 , self.size.height / 2.5)
        playAgainBtn.zPosition = 9
        self.addChild(playAgainBtn)
        
        homePageBtn = SKSpriteNode(imageNamed: "HomePage")
        homePageBtn.position = CGPointMake(self.size.width / 2, self.size.height / 2.5 - 70 )
        homePageBtn.zPosition = 9
        self.addChild(homePageBtn)
        
    }
    
    func goToGameScene(){
        let gameScene:GameScene = GameScene(size: self.size) // create your new scene
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0) // create type of transition (you can check in documentation for more transtions)
        gameScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(gameScene, transition: transition)
    }
    
    func goToHomeScene() {
        let homeScene: HomeScene = HomeScene(size: self.size)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0)
        homeScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(homeScene, transition: transition)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if btnsAppear {
                if playAgainBtn.containsPoint(location){
                    goToGameScene()
                } else if homePageBtn.containsPoint(location) {
                    goToHomeScene()
                }
            }
            
        }
    }
    
    func setScreen() {
        self.physicsWorld.contactDelegate = self
        setBackGround()
        setGround()
        setPlayer()
        
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        setScoreLabel()
        self.addChild(scoreLabel)
        
        player.setImage()
        for x in 1...5 {
            let wait = SKAction.waitForDuration(2 * Double(x))
            self.runAction(wait, completion: { () -> Void in
                let cloud = Clouds()
                self.clouds.append(cloud)
                self.addChild(cloud)
                cloud.startMoving()
            })
        }
        
        
        rockTimer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: #selector (GameScene.fallingRocks), userInfo: nil, repeats: false)
        
    }
    
    func addRock() {
        let stone = Stones()
        self.rockArr.append(stone)
        self.addChild(stone)
        stone.startMoving()
    }
    
    func didBeginContact(contact: SKPhysicsContact){
        if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_ROCK || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_ROCK {
            self.removeAllActions()
            btnsAppear = true
            for node in rockArr {
                node.removeAllActions()
            }
            
            for node in clouds {
                node.removeAllActions()
            }
            
            
            musicPlayer.stop()
            self.runAction(SKAction.playSoundFileNamed("gameOver", waitForCompletion: false))
            print("collision was made")
            player.gameOver = true
            self.removeChildrenInArray(rockArr)
            self.removeChildrenInArray(clouds)
            
            NSNotificationCenter.defaultCenter().postNotificationName("showInterAdKey", object: nil)
            
            setBtns()
            
            
            if let lastScore = NSUserDefaults.standardUserDefaults().valueForKey("score") as? Int {
                if score > lastScore {
                    NSUserDefaults.standardUserDefaults().setValue(score, forKey: "score")
                }
            }else {
                NSUserDefaults.standardUserDefaults().setValue(score, forKey: "score")
            }
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    
    func playLevelMusic() {
        
        let levelMusicURL = NSBundle.mainBundle().URLForResource("gameMusic", withExtension: "wav")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: levelMusicURL)
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch {
            
        }
        
        
    }
    
    func processUserMotionForUpdate(currentTime: CFTimeInterval) {
        // 1
        if let ship = childNodeWithName(playerName) as? SKSpriteNode {
            // 2
            if let data = motionManager.accelerometerData {
                // 3
                if fabs(data.acceleration.x) > 0.2 {
                    // 4 How do you move the ship?
                    ship.physicsBody!.applyForce(CGVectorMake(20.0 * CGFloat(data.acceleration.x), 0))
                    
                }
            }
        }
    }
    
    
    
    
}