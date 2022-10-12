//
//  Ball.swift
//  Ballider
//
//  Created by Yemlihan Sapan on 12.10.2022.
//

import Foundation
import SpriteKit

class Ball: SKNode {
    
    
    private var sceneFrame = CGRect()
  
    override init() {
        super.init()
    }
    
    func buildBall(){
       
        
        
    }
    
    
    func getSceneFrame(sceneFrame: CGRect){
        self.sceneFrame = sceneFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
