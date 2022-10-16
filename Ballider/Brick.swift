//
//  Brick.swift
//  Ballider
//
//  Created by Sinem Ünal on 16.10.2022.
//

import Foundation
import SpriteKit

class Brick: SKSpriteNode {
    
    private let brickTexture = SKTexture(imageNamed: "Brick")
    private var sceneFrame = CGRect()
    private var originalPosition : CGPoint?
    private var width = CGFloat()
    private var height = CGFloat()
    
    init() {
        super.init(texture: brickTexture, color: SKColor.clear, size: brickTexture.size())
        self.setWidth(width: 100)
        self.setHeight(height: 100)
        self.size = CGSize(width: getWidth(), height: getHeight())
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
    }
   
    func setup(){
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.mass = 0.4
        self.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.friction = 1.0
        self.zPosition = 6
        self.originalPosition = CGPoint(x: 0, y: -(self.size.height/2 * 12.3))
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
        let xRange = SKRange(lowerLimit:-(self.size.width + self.size.width/2 * 3.3),upperLimit:self.size.height  +  self.size.height/2 * 3.3)
        self.constraints =  [SKConstraint.positionX(xRange)]
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
