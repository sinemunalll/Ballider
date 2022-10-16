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
        self.originalPosition = self.position
        self.size = CGSize(width: getWidth(), height: getHeight())
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)


      
    }
   
    func setup(){
        self.position = CGRect(x: self.size.width / 2.2 , y: 0, width: getWidth(), height: getHeight())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.mass = 0.4
        self.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        self.position = self.originalPosition!


        
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
        let xRange = SKRange(lowerLimit:-(self.size.width + self.size.width/2 * 1.3),upperLimit:self.size.width  +  self.size.width/2 * 1.3)
        self.constraints =  [SKConstraint.positionX(xRange)]
     }
    

   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
