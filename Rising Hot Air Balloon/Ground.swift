//
//  Ground.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class Ground: Moveable {
    
    convenience init() {
        self.init(imageNamed: "Bottom")
        self.startMoving()
    }
    
    override func startMoving() {
        self.zPosition = 2
        self.position = CGPointMake(GameScene.SCENE_WIDTH / 2, 28)
        super.startMoving()
    }
    
    override func update() {
        
    }
    
}