//
//  Ball.swift
//  Ballider
//
//  Created by Yemlihan Sapan on 12.10.2022.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode {
    
    private let ballTexture = SKTexture(imageNamed: "Ball")
    private var sceneFrame = CGRect()
    public var width = CGFloat()
    private var originalPosition : CGPoint?
    
    init() {
        super.init(texture: ballTexture, color: SKColor.clear, size: ballTexture.size())
        self.width = 100
        self.originalPosition = self.position
      
    }
    
    func setupBall(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: ballTexture.size().height / 10)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = true
        self.physicsBody?.mass = 0.25
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.friction = 1.0
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.angularVelocity = 0
        self.zPosition = 1
        self.isHidden = false
        self.position = self.originalPosition!
        self.zPosition = 4
        self.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 50)
      
    }
    func reload(){
    
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.friction = 1.0
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.angularVelocity = 0
        self.zPosition = 1
        self.isHidden = false
        self.zPosition = 4
        self.position = self.originalPosition!
        self.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 50)
    }
    func getSceneFrame(sceneFrame: CGRect){
        self.sceneFrame = sceneFrame
    }
    func getOriginalPositions() -> (CGPoint) {
        return self.originalPosition!
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func colliderBall() {
        
        self.physicsBody?.contactTestBitMask = ColliderType.Birck.rawValue
        self.physicsBody?.categoryBitMask = ColliderType.Birck.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Birck.rawValue
    }
}

