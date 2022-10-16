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
    private var originalPosition : CGPoint?
    private var width = CGFloat()
    private var height = CGFloat()
   
    init() {
        super.init(texture: ballTexture, color: SKColor.clear, size: ballTexture.size())
        self.setWidth(width: 65)
        self.setHeight(height: 65)
        self.originalPosition = self.position
        self.physicsBody = SKPhysicsBody(circleOfRadius: ballTexture.size().height / 10)
    }
   
    func setup(){
        self.size.width = self.width
        self.size.height = self.height
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
    }
  
    func getSceneFrame(sceneFrame: CGRect){
        self.sceneFrame = sceneFrame
    }
    
    func getOriginalPositions() -> (CGPoint) {
        return self.originalPosition!
    }
        
    func getWidth()->(CGFloat){
         return self.width
    }
    
    func setWidth(width :CGFloat){
        self.width = width
    }
     
    func getHeight()->(CGFloat){
         return self.height
    }
    
    func setHeight(height :CGFloat){
         self.height = height
    }
    
    func collider() {
        self.physicsBody?.contactTestBitMask = ColliderType.Birck.rawValue
        self.physicsBody?.categoryBitMask = ColliderType.Birck.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Birck.rawValue
    }
    
    func constraint() {
        let xRangeBall = SKRange(lowerLimit:-(self.size.width + self.getWidth() * 3.7),upperLimit:self.size.height + self.getWidth() * 3.7)
        self.constraints = [SKConstraint.positionX(xRangeBall)]
     }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

