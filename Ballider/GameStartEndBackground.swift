//
//  GameStartEndBackground.swift
//  Ballider
//
//  Created by Yemlihan Sapan on 23.10.2022.
//

import Foundation
import SpriteKit

class GameStartEndBackground: SKSpriteNode {
    
    private var gameStartEndBackgroundTexture = SKTexture(imageNamed: "GameStartEndBackground")
    private var sceneFrame = CGRect()
    private var originalPosition : CGPoint?
    private var width = CGFloat()
    private var height = CGFloat()
    
    init() {
        super.init(texture: gameStartEndBackgroundTexture, color: SKColor.clear, size: CGSize(width: 10000, height: 10000))
        self.position = CGPoint(x: 0, y: 100)
    }
    
    func buildGameStartEndBackground(){
        self.zPosition = 8
    }
    
    func showGameStartEndBg(){
        self.isHidden = true
    }
    
    func hideGameStartEndBg(){
        self.isHidden = false
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
