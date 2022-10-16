//
//  GameScene.swift
//  Ballider
//
//  Created by Sinem Ünal on 16.09.2022.
//

import SpriteKit
import GameplayKit

enum ColliderType : UInt32{
     case Ball = 1
     case Birck = 2
 }
 

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    
    let ball = Ball()
    var brick = SKSpriteNode()
    var originalPosition : CGPoint?
    var brickPosition : CGPoint?
    
    var scoreText = UILabel()
    var scoreLabel = Score()
    var highScoreLabel = HighScore()
    var button = Button()
   
    var score = 0
    var highScore = 0
    
    var defaults = UserDefaults.standard
    
    var brickWidth = 0
    var brickHeight = 0
    
    var gameStarted = false
    
    var progressBar = ProgressBar()
    var progressCount = 0
    
    var lv1 = 10
    
  
    override func didMove(to view: SKView) {
        
        ball.getSceneFrame(sceneFrame: frame)
        addChild(ball)
        
        progressBar.getSceneFrame(sceneFrame: frame)
        progressBar.buildProgressBar()
        addChild(progressBar)
        
        scoreLabel.getSceneFrame(sceneFrame: frame)
        scoreLabel.buildScore()
        addChild(scoreLabel)
        
        highScoreLabel.getSceneFrame(sceneFrame: frame)
        highScoreLabel.buildHighScore()
        addChild(highScoreLabel)
        
        button.getSceneFrame(sceneFrame: frame)
        addChild(button)
        

        
        physicsWorld.contactDelegate = self
    
        brick = childNode(withName: "Brick") as! SKSpriteNode
        let width2 =  brick.size.width/2
        let height2 =  brick.size.height/2
        let xRange = SKRange(lowerLimit:-(brick.size.width + width2 * 1.3),upperLimit:brick.size.width + width2 * 1.3)
        brick.constraints = [SKConstraint.positionX(xRange)]
        
        let widthBall =  ball.width
        let xRangeBall = SKRange(lowerLimit:-(ball.size.width + widthBall * 2.6),upperLimit:ball.size.width + widthBall * 2.6)
        ball.constraints = [SKConstraint.positionX(xRangeBall)]
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.contactDelegate = self
        
      
        let brickTexture  = SKTexture(imageNamed: "Brick")
     
      
        
        ball.setupBall()
        
        //çarpışma
        ball.colliderBall()
    
        
        brickWidth = Int(brickTexture.size().width)
        brickHeight = Int(brickTexture.size().height)
        
        let brickSize = CGSize(width: brickWidth, height: brickHeight)
        brick.physicsBody = SKPhysicsBody(rectangleOf: brickSize)
        
        brick.physicsBody?.affectedByGravity = false
        brick.physicsBody?.isDynamic = true
        brick.physicsBody?.allowsRotation = true
        brick.physicsBody?.mass = 0.4
        brick.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        brickPosition = brick.position
    
        self.storeHighScoreCheck()
 
       
   
    }
    
    func storeHighScoreCheck(){
      
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
    
        if storedHighScore == nil {
            highScore = 0
           // highScoreLabel.text = "HighScore : \(self.highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            //highScoreLabel.text = "HighScore : \(self.highScore)"
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        self.nextLevel()
        gameStarted = true
         if contact.bodyA.collisionBitMask == ColliderType.Ball.rawValue || contact.bodyB.collisionBitMask == ColliderType.Ball.rawValue {
             
             ball.physicsBody?.applyImpulse(randomImpulse(dxPosition: -500, dyPosition: 500))
             ball.physicsBody?.affectedByGravity = true
             
             let newBrickWidth = brickWidth
             brickWidth = brickWidth - 10
             brickHeight = brickHeight - 10
             
            /* if newBrickWidth > 50 {
                 brick.size = CGSize(width: brickWidth, height: brickHeight)
             }*/
             score += 1
             scoreLabel.changeString(score: score)
             scoreLabel.run(.sequence([.scale(to: 1.3, duration: 0.1),.scale(to: 1.0, duration: 0.1)])) //effect scale
             
             
             if score > highScore {
                 highScore = score
                 defaults.set(highScore, forKey: "highScore")
                // highScoreLabel.text = "HighScore : \(self.highScore)"

             }
             
            if self.progressCount <= 10 {
                 
                 self.progressBar.updateProgressBar(updateProgress: 1, updateDurationProgress: 0.1)
                 
                 self.progressCount += 1
             }
         }
     }
    
    func randomImpulse(dxPosition: CGFloat, dyPosition: CGFloat) -> CGVector {
        let dx = (CGFloat.random(in: -(250)...250) - ball.position.x)
        let dy = -((ball.position.y) - ball.getOriginalPositions().y)
        let impulse = CGVector(dx: dx, dy: dy)
        return impulse
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
                button.hideButton()
                ball.isHidden = true
                brick.position = brickPosition!
                
                highScoreLabel.changeString(score: self.highScore)
                highScoreLabel.changeVisibility(visible: true)
            
                self.progressBar.clearProgress(clearCount: 1)
            }
        }
    }
    
    func loadGameScene() {
        button.showButton()
        ball.reload()
        gameStarted = false
        score = 0
        scoreLabel.changeString(score: score)
        scoreLabel.run(.sequence([.scale(to: 1.3, duration: 0.1),.scale(to: 1.0, duration: 0.1)]))
        self.progressCount = 0
        highScoreLabel.showScore()
    }
    
    func nextLevel(){
        if score == lv1 {
            self.sceneDidLoad()
            self.loadGameScene()
        }
    }
       
}
