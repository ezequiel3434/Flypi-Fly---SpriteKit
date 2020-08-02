//
//  GameScene.swift
//  Flypi Fly - SpriteKit
//
//  Created by Ezequiel Parada Beltran on 02/08/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    var fly = SKSpriteNode()
    var BGImage = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        
        //Background
               
               let texturaFondo = SKTexture(imageNamed: "fondo.png")
               BGImage = SKSpriteNode(texture: texturaFondo)
               
               BGImage.size.height = self.frame.height
                
        BGImage.zPosition = -1
               self.addChild(BGImage)
        
        // Fly
        let flyTexture1 = SKTexture(imageNamed: "fly1.png")
        let flyTexture2 = SKTexture(imageNamed: "fly2.png")
        
        //Actions
        
        let animation = SKAction.animate(with: [flyTexture1, flyTexture2], timePerFrame: 0.08)
        let infiniteAnimation = SKAction.repeatForever(animation)
        
       fly = SKSpriteNode(texture: flyTexture1)
        
        fly.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        fly.run(infiniteAnimation)
        
        self.addChild(fly)
        
       
        
       
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
   
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
