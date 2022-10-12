//
//  Button.swift
//  Ballider
//
//  Created by Yemlihan Sapan on 12.10.2022.
//

import Foundation
import SpriteKit

class Button: SKSpriteNode{
    
    private let button = SKSpriteNode()
    private let buttonTexture = SKTexture(imageNamed: "PlayButton")
        
    private var sceneFrame = CGRect()
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: buttonTexture, color: UIColor.clear, size: buttonTexture.size())
        self.name = "PlayButton"
        self.size.height = 100
        self.size.width = 100
        self.isHidden = true
        self.zPosition = 2
        self.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 50)
    }
    
    func changeVisibility(visible: Bool){
        if visible == true {
            self.isHidden = false
        }
    }
    
    func showButton(){
        self.isHidden = true
    }
    
    func hideButton(){
        self.isHidden = false
    }
    
    
    func getSceneFrame(sceneFrame: CGRect){
        self.sceneFrame = sceneFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
