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
        let BGMovement = SKAction.move(by: CGVector(dx: -texturaFondo.size().width, dy: 0), duration: 4)
        let BGMovement2 = SKAction.move(by: CGVector(dx: texturaFondo.size().width, dy: 0), duration: 0)
        
        let infiniteBGMovement = SKAction.repeatForever(SKAction.sequence([BGMovement,BGMovement2]))
        
        
        
        var i: CGFloat = 0
        
        while i<2 {
            
        
        
        
        BGImage = SKSpriteNode(texture: texturaFondo)
               
        BGImage.size.height = self.frame.height
        
        
        BGImage.position = CGPoint(x: texturaFondo.size().width * i, y: self.frame.midY)
        BGImage.zPosition = -1
        
        BGImage.run(infiniteBGMovement)
        self.addChild(BGImage)
        
            i += 1
            
        }
        // Fly
        let flyTexture1 = SKTexture(imageNamed: "fly1.png")
        let flyTexture2 = SKTexture(imageNamed: "fly2.png")
        
        //Actions
        
        let animation = SKAction.animate(with: [flyTexture1, flyTexture2], timePerFrame: 0.08)
        let infiniteAnimation = SKAction.repeatForever(animation)
        
       fly = SKSpriteNode(texture: flyTexture1)
        
        fly.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        print(flyTexture1.size().width)
        print(fly.frame.width)
        
        fly.run(infiniteAnimation)
        
        self.addChild(fly)
        
       
        
       
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fly.physicsBody = SKPhysicsBody(circleOfRadius: fly.frame.height/2)
              
        fly.physicsBody!.isDynamic = true
        
        fly.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        fly.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 100))
    }
    
   
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
