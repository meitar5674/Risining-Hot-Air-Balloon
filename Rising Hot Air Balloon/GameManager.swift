//
//  GameManager.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class GameManager {
    static let sharedInstance = GameManager()
    
    let MOVEMENT_SPEED: CGFloat = -8
    
    // Colliders
    let COLLIDER_ROCK: UInt32 = 1 << 0
    let COLLIDER_PLAYER: UInt32 = 1 << 1
    
}
