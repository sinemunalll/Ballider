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
    
    override init() {
        super.init()
    }
    
    func buildScore(){
       
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 30
        scoreLabel.color = UIColor(named: "black")
        scoreLabel.text = "0"
        scoreLabel.position.y = sceneFrame.height / 3
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
    }
    func changeString(score: Int){
        self.scoreLabel.text = String(score)
    }
    
    func getSceneFrame(sceneFrame: CGRect){
        self.sceneFrame = sceneFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
