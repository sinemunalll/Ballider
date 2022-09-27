//
//  GameScene.swift
//  Ballider
//
//  Created by Sinem Ünal on 16.09.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    let button = SKSpriteNode(imageNamed: "PlayButton")
    var ball = SKSpriteNode()
    var brick = SKSpriteNode()
    var originalPosition : CGPoint?
    
    var scoreText = UILabel()
    var scoreLabel = SKLabelNode()
    var score = 0
    
    var brickWidth = 0
    var brickHeight = 0
    
    var gameStarted = false
    
    enum ColliderType : UInt32{
         case Ball = 1
         case Birck = 2
     }
     
    
    override func didMove(to view: SKView) {
     
        physicsWorld.contactDelegate = self
        ball = childNode(withName: "Ball") as! SKSpriteNode
        brick = childNode(withName: "Brick") as! SKSpriteNode
        let width2 =  brick.size.width/2
        let height2 =  brick.size.height/2
        let xRange = SKRange(lowerLimit:-(brick.size.width + width2 * 1.3),upperLimit:brick.size.width + width2 * 1.3)
       
        let widthBall =  ball.size.width
        let xRangeBall = SKRange(lowerLimit:-(ball.size.width + widthBall * 2.6),upperLimit:ball.size.width + widthBall * 2.6)
               
        brick.constraints = [SKConstraint.positionX(xRange)]
        ball.constraints = [SKConstraint.positionX(xRangeBall)]
        
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
        
        brickWidth = Int(brickTexture.size().width)
        brickHeight = Int(brickTexture.size().height)
        
        let brickSize = CGSize(width: brickWidth, height: brickHeight)
        brick.physicsBody = SKPhysicsBody(rectangleOf: brickSize)
        
        brick.physicsBody?.affectedByGravity = false
        brick.physicsBody?.isDynamic = true
        brick.physicsBody?.allowsRotation = true
        brick.physicsBody?.mass = 0.4
        brick.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
    
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 30
        scoreLabel.color = UIColor(named: "black")
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 3)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        button.name = "PlayButton"
        button.size.height = 100
        button.size.width = 100
        button.isHidden = true
        button.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 50)
      
        self.addChild(button)
        
   
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        gameStarted = true
         if contact.bodyA.collisionBitMask == ColliderType.Ball.rawValue || contact.bodyB.collisionBitMask == ColliderType.Ball.rawValue {
             let dx = (CGFloat.random(in: -(ball.size.width)...ball.size.width) - originalPosition!.x)
             let dy = -((ball.position.y) - originalPosition!.y)
             
             let impulse = CGVector(dx: dx, dy: dy)
             ball.physicsBody?.applyImpulse(impulse)
             ball.physicsBody?.affectedByGravity = true
            
             
             let newBrickWidth = brickWidth
             brickWidth = brickWidth - 10
             brickHeight = brickHeight - 10
             
            /* if newBrickWidth > 50 {
                 brick.size = CGSize(width: brickWidth, height: brickHeight)
             }*/
             score += 1
             scoreLabel.text = String(score)
             
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
            let touchLocation = touch.location(in: self)
            let touchNodes = nodes(at: touchLocation) 
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == brick {
                                brick.position = CGPoint(x:touchLocation.x, y:brick.position.y)
                        }
                            if sprite == button {
                                self.loadGameScene()
                            }
                        
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
                    let touchLocation = touch.location(in: self)
          
                   let touchNodes = nodes(at: touchLocation) //dokunulan yerdeki node
                           if touchNodes.isEmpty == false {
                                 for node in touchNodes {
                                     
                                     if let sprite = node as? SKSpriteNode {
                                         if sprite == brick {
                                             brick.position = CGPoint(x:touchLocation.x, y:brick.position.y)
                                            
                                         }
                                         if sprite == button {
                                             self.loadGameScene()
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
        if let ballPhysicsBody = ball.physicsBody {
        
            if ballPhysicsBody.velocity.dy == 0.0 && gameStarted == true {
                button.isHidden = false
                ball.isHidden = true
            
                
            }
        }
    }
    
    func loadGameScene() {
        button.isHidden = true
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.physicsBody?.angularVelocity = 0
        ball.zPosition = 1
        ball.isHidden = false
        ball.position = originalPosition!
        gameStarted = false
        score = 0
        scoreLabel.text = String(score)
    }
}
