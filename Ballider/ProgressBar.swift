//
//  ProgressBar.swift
//  Ballider
//
//  Created by Yemlihan Sapan on 28.09.2022.
//

import Foundation
import SpriteKit

class ProgressBar: SKNode {
    private var progress = CGFloat(1)
    private var maxProgress = CGFloat(10)
    private var maxProgressBarWidth = CGFloat(0)
    
    private var progressBar = SKSpriteNode()
    private var progressBarContainer = SKSpriteNode()
    
    private let progressTexture = SKTexture(imageNamed: "ProgressBar")
    private let progressContainerTexture = SKTexture(imageNamed: "ProgressBarContainer")
    
    private var sceneFrame = CGRect()
    
    override init(){
        super.init()
    }
    
    func getSceneFrame(sceneFrame: CGRect){
        self.sceneFrame = sceneFrame
        maxProgressBarWidth = sceneFrame.width * 0.65
    }
    
    func buildProgressBar(){
        progressBarContainer = SKSpriteNode(texture: progressContainerTexture, size: progressBarContainer.size)
        progressBarContainer.size.width = sceneFrame.width * 0.54
        progressBarContainer.size.height = sceneFrame.height * 0.1
        progressBarContainer.position.x = -sceneFrame.width / 15
        progressBarContainer.position.y = sceneFrame.height / 4.8
        progressBarContainer.zPosition = 1
        progressBarContainer.anchorPoint = CGPoint(x: 0.4, y: 0.5)
        
        progressBar = SKSpriteNode(texture: progressTexture, size: progressBar.size)
        progressBar.size.width = sceneFrame.width * 0
        progressBar.size.height = sceneFrame.height * 0.1
        progressBar.position.x = -sceneFrame.width / 3.7
        progressBar.position.y = sceneFrame.height / 5
        progressBar.zPosition = 2
        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        addChild(progressBar)
        addChild(progressBarContainer)
        
    }
    
    func updateProgressBar(updateProgress: CGFloat, updateDurationProgress: CGFloat){
        if progress >= maxProgress {return}
        
        progressBarContainer.isHidden = false
        
        progressBar.run(SKAction.resize(toWidth: CGFloat(progress / maxProgress) * maxProgressBarWidth, duration: updateDurationProgress))
            
        if updateProgress > 0 {
            progress += 1
        }
    }
    
    func clearProgress(clearCount: CGFloat){
        if clearCount == 1 {
            progressBar.run(SKAction.resize(toWidth: CGFloat(0), duration: 0))
            progressBar.size.width = sceneFrame.width * 0
            progress = 1
            progressBarContainer.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder) has not been implemented")
    }
}
