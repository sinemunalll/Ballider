//
//  Score.swift
//  Ballider
//
//  Created by Yemlihan Sapan on 12.10.2022.
//

import Foundation
import SpriteKit

class Score: SKNode {
    
    private var scoreLabel = SKLabelNode()
    
    private var sceneFrame = CGRect()
    private var score : Int?
    private var scorePosition : CGPoint?
    
    override init() {
        self.score = 0
        self.scorePosition = CGPoint(x: -240, y: 550)
        super.init()
    }
    
    func buildScore(){
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 30
        scoreLabel.color = UIColor(named: "black")
        scoreLabel.text = "Score : \(self.score!)"
        scoreLabel.position = self.scorePosition!
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
    }
    func setPosition(x : Int,y : Int) {
        self.scorePosition = CGPoint(x: x, y: y);
        scoreLabel.position = self.scorePosition!;
    }
    func changeString(score: Int){
        self.score = score
        scoreLabel.text = "Score : \(self.score!)"
    }
    
    func getSceneFrame(sceneFrame: CGRect){
        self.sceneFrame = sceneFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
