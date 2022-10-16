//
//  HighScore.swift
//  Ballider
//
//  Created by Yemlihan Sapan on 12.10.2022.
//

import Foundation
import SpriteKit

class HighScore: SKNode{
    private var highScoreLabel = SKLabelNode()
    private var sceneFrame = CGRect()
    
    override init() {
        super.init()
    }
    
    func buildHighScore(){
        highScoreLabel.fontName = "Helvetica"
        highScoreLabel.fontSize = 30
        highScoreLabel.color = UIColor(named: "black")
        highScoreLabel.position.y = sceneFrame.height / 3.3
        highScoreLabel.zPosition = 2
        highScoreLabel.isHidden = true
       
        self.addChild(highScoreLabel)
    }
    
    func changeString(score: Int){
        self.highScoreLabel.text = "HighScore : \(score)"
    }
    
    func changeVisibility(visible: Bool){
        if visible == true {
            highScoreLabel.isHidden = false
        }
    }
    
    func showScore(){
        highScoreLabel.isHidden = true
    }
    
    func getSceneFrame(sceneFrame: CGRect){
        self.sceneFrame = sceneFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
