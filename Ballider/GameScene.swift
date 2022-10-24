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
    
    static let LEVEL_MAX_POINT = 5
    
    let ball = Ball()
    let brick = Brick()
    let gameStartEndBackground = GameStartEndBackground()
    let voice = Voice()
    
    var scoreText = UILabel()
    var scoreLabel = Score()
    var highScoreLabel = HighScore()
    var button = Button()
   
    var score = 0
    var highScore = 0
    
    var defaults = UserDefaults.standard
    
    
    var gameStarted = false
    
    var progressBar = ProgressBar()
    var progressCount = 0
    
    var lv1 = 10
    
    let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
    
    
  
    override func didMove(to view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.contactDelegate = self
        
        gameStartEndBackground.getSceneFrame(sceneFrame: frame)
        addChild(gameStartEndBackground)
        
        voice.getSceneFrame(sceneFrame: frame)
        voice.buildVoice()
        addChild(voice)
        
        ball.getSceneFrame(sceneFrame: frame)
        addChild(ball)
        
        brick.getSceneFrame(sceneFrame: frame)
        addChild(brick)
        
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
        
        brick.constraint()
        brick.setup()
        brick.position = brick.getOriginalPositions()
        
        ball.constraint()
        ball.setup()
        ball.collider()// carpisma
        
        self.checkStoreHighScore()
   
    }
    
    func checkStoreHighScore(){
      
        if self.storedHighScore == nil {
            highScore = 0
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
        }
    }
    

    
    func didBegin(_ contact: SKPhysicsContact) {
        self.nextLevel()
        gameStarted = true
         if contact.bodyA.collisionBitMask == ColliderType.Ball.rawValue || contact.bodyB.collisionBitMask == ColliderType.Ball.rawValue {
             
             ball.physicsBody?.applyImpulse(randomImpulse(dxPosition: -500, dyPosition: 500))
        
             self.scoreIncreaseAndChangeScoreLabel()
             scoreLabel.run(.sequence([.scale(to: 1.3, duration: 0.1),.scale(to: 1.0, duration: 0.1)])) //effect scale
             
             self.checkAndSetHighScore()
             
             if self.score <= GameScene.LEVEL_MAX_POINT {
                self.updateProgressBar()
             }
         }
     }
    
    func scoreIncreaseAndChangeScoreLabel(){
        self.score += 1
        scoreLabel.changeString(score: score)
    }
    
    public func checkAndSetHighScore(){
        if self.score > self.highScore {
            self.highScore = self.score
            defaults.set(highScore, forKey: "highScore")
        }
    }
    
    
    public func updateProgressBar(){
        self.progressBar.updateProgressBar(updateProgress: 1, updateDurationProgress: 0.1)
        self.progressCount += 1
    }
    
    
    func randomImpulse(dxPosition: CGFloat, dyPosition: CGFloat) -> CGVector {
        let dx = (CGFloat.random(in: -(250)...250) - ball.position.x)
        let dy = -((ball.position.y) - ball.getOriginalPositions().y)
    
        return CGVector(dx: dx, dy: dy)
    }
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches(touches: touches)
    }
    
   
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let ballPhysicsBody = ball.physicsBody {
        
            if ballPhysicsBody.velocity.dy == 0.0 && gameStarted == true {
                button.hideButton()
                voice.hideVoice()
                gameStartEndBackground.hideGameStartEndBg()
                ball.isHidden = true
                brick.position = brick.getOriginalPositions()
                
                highScoreLabel.changeString(score: self.highScore)
                highScoreLabel.changeVisibility(visible: true)
            
                self.progressBar.clearProgress(clearCount: 1)
            }
        }
    }
    
    func loadGameScene() {
        button.showButton()
        voice.showVoice()
        gameStartEndBackground.isHidden = false
        gameStartEndBackground.showGameStartEndBg()
        ball.setup()
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
    
    func touches(touches: Set<UITouch>){
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
                        if let sprinteNode = node as? SKNode {
                            if sprinteNode == voice {
                                voice.changeVoice()
                            }
                        }
                    }
                }
        }
    }
       
}
