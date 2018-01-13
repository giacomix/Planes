//
//  GameScene.swift
//  Planes
//
//  Created by Giacomo perez on 13/01/18.
//  Copyright © 2018 Giacomo Perez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ship = SKSpriteNode()
    var actionMoveUp = SKAction()
    var actionMoveDown = SKAction()
    let shipCategory = 0x1 << 1
    let obstacleCategory = 0x1 << 2
    
    
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.white
        
        self.addShip()
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    func addShip() {
        // Inizializa una nave
        ship = SKSpriteNode(imageNamed: "spaceship")
        ship.setScale(1.5)
        ship.zRotation = CGFloat(-Double.pi / 2)
        
        // aggiungiamo physics body for collision detection
        
        ship.physicsBody = SKPhysicsBody(circleOfRadius: ship.size.width)
        ship.physicsBody?.categoryBitMask = UInt32(shipCategory)
        ship.physicsBody?.isDynamic = true
        ship.physicsBody?.contactTestBitMask = UInt32(obstacleCategory)
        ship.physicsBody?.collisionBitMask = 0
        ship.name = "ship"
        ship.position = CGPoint(x: 0, y: 0)
        
        self.addChild(ship)
        
        actionMoveUp = SKAction.move(by: CGVector(dx: 0, dy: 30), duration: 0.2)
        actionMoveDown = SKAction.move(by: CGVector(dx: 0, dy: -30), duration: 0.2)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("il primo touch")
        
        for touch: AnyObject in touches {
            let location  = touch.location(in: self)
            if location.y > ship.position.y {
               ship.run(actionMoveUp)
            } else {
                ship.run(actionMoveDown)
            }
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("posizione del touch")
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touch finalizzato")
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
