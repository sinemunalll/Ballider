//
//  GameScene.swift
//  Ballider
//
//  Created by Sinem Ünal on 16.09.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var ball = SKSpriteNode()
    var brick = SKSpriteNode()
    var originalPosition : CGPoint?
    
    enum ColliderType : UInt32{
         case Ball = 1
         case Birck = 2
     }
     
    
    override func didMove(to view: SKView) {
     
        
        ball = childNode(withName: "Ball") as! SKSpriteNode
        brick = childNode(withName: "Brick") as! SKSpriteNode
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.contactDelegate = self
        
        let ballTexture  = SKTexture(imageNamed: "Ball")
        let brickTexture  = SKTexture(imageNamed: "Brick")
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballTexture.size().height / 10)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.mass = 0.25
        originalPosition = ball.position
        
        //çarpışma
        ball.physicsBody?.contactTestBitMask = ColliderType.Birck.rawValue
        ball.physicsBody?.categoryBitMask = ColliderType.Birck.rawValue
        ball.physicsBody?.collisionBitMask = ColliderType.Birck.rawValue
   
     
        let brickSize = CGSize(width: brickTexture.size().width, height: brickTexture.size().height)
        brick.physicsBody = SKPhysicsBody(rectangleOf: brickSize)
        brick.physicsBody?.affectedByGravity = false
        brick.physicsBody?.isDynamic = true
        brick.physicsBody?.allowsRotation = true
        brick.physicsBody?.mass = 0.4
        brick.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
       
   
    }
    func didBegin(_ contact: SKPhysicsContact) {
         if contact.bodyA.collisionBitMask == ColliderType.Ball.rawValue || contact.bodyB.collisionBitMask == ColliderType.Ball.rawValue {
             let dx = -((ball.position.x) - originalPosition!.x)
             let dy = -((ball.position.y) - originalPosition!.y)
                                                               
                let impulse = CGVector(dx: dx, dy: dy)
                print(impulse)
                ball.physicsBody?.applyImpulse(impulse)
                ball.physicsBody?.affectedByGravity = true
         }
     }
 
    
    
    func touchDown(atPoint pos : CGPoint) {
     
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self) // dokunulan yer
            let touchNodes = nodes(at: touchLocation) //dokunulan yerdeki node
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == brick {
                                brick.position = CGPoint(x:touchLocation.x, y:brick.position.y)
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
                    let touchLocation = touch.location(in: self) // dokunulan yer
          
                   let touchNodes = nodes(at: touchLocation) //dokunulan yerdeki node
                           if touchNodes.isEmpty == false {
                                 for node in touchNodes {
                                     
                                     if let sprite = node as? SKSpriteNode {
                                         if sprite == brick {
                                             brick.position = CGPoint(x:touchLocation.x, y:brick.position.y)
                                        
                                                
                                         }
                                     }
                                 }
                             }
                         }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
