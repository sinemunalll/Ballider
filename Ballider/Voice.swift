//
//  Voice.swift
//  Ballider
//
//  Created by Yemlihan Sapan on 23.10.2022.
//

import Foundation
import SpriteKit

class Voice: SKNode {
    private var voice = SKSpriteNode()
    private var voiceOpenTexture = SKTexture(imageNamed: "VoiceOpen")
    private var voiceCloseTexture = SKTexture(imageNamed: "VoiceClose")
    private var voiceStatus = Int()
    private var sceneFrame = CGRect()
    
    override init() {
        super.init()
    }
    
    func buildVoice(){
        voice = SKSpriteNode(texture: voiceOpenTexture, color: SKColor.clear, size: CGSize(width: 50, height: 50))
        voice.position.x = -sceneFrame.width / 15
        voice.position.y = sceneFrame.height / 4.8
        voice.zPosition = 7
        voice.anchorPoint = CGPoint(x: -0.5, y: 2)
        addChild(voice)
    }
    
    func changeVoice(){
        if self.voiceStatus == 1 {
            self.voiceStatus = 0
            voice.run(SKAction.setTexture(voiceCloseTexture))
        } else {
            self.voiceStatus = 1
            voice.run(SKAction.setTexture(voiceOpenTexture))
        }
    }
    
    func showVoice(){
        self.isHidden = true
    }
    
    func hideVoice(){
        self.isHidden = false
    }
    
    func getSceneFrame(sceneFrame: CGRect){
        self.sceneFrame = sceneFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
