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
    
    var tube = SKNode()
    var tube2 = SKNode()
    
    override func didMove(to view: SKView) {
        
        
        // Fly
              
              addFly()
              
        
        //Background
        addBackground()
        
        // Ground
        addGround()
        
        // tubes
        addTubes()
        
        
      
       
        
       
    }
    
    func addBackground(){
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
    }
    
    func addGround() {
        let ground = SKNode()
        ground.position = CGPoint(x: -self.frame.midX, y: -self.frame.height/2)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        ground.physicsBody!.isDynamic = false
        self.addChild(ground)
        
        
    }
    
    func addTubes() {
        
        let gapDifficulty = fly.size.height * 3
        
        //Numoro entre 0 y lo mitad del alto de la pantalla
        let randomMovement = CGFloat(arc4random() % UInt32(self.frame.height/2))
        
        let compensation = randomMovement - self.frame.height / 4
        
        
        let tubeTexture = SKTexture(imageNamed: "Tubo1.png")
        let tubeTexture2 = SKTexture(imageNamed: "Tubo2.png")
        tube = SKSpriteNode(texture: tubeTexture)
        tube2 = SKSpriteNode(texture: tubeTexture2)
        
        tube.position = CGPoint(x: 0.0, y: self.frame.midY + tubeTexture.size().height / 2 + gapDifficulty + compensation)
        tube.zPosition = 0
        tube2.zPosition = 0
        tube2.position = CGPoint(x: 0.0, y: -(self.frame.midY + tubeTexture.size().height / 2) - gapDifficulty + compensation)
        self.addChild(tube2)
        self.addChild(tube)
        
    }
    
    func addFly() {
        let flyTexture1 = SKTexture(imageNamed: "fly1.png")
         let flyTexture2 = SKTexture(imageNamed: "fly2.png")
         
         //Actions
         
         let animation = SKAction.animate(with: [flyTexture1, flyTexture2], timePerFrame: 0.08)
         let infiniteAnimation = SKAction.repeatForever(animation)
         
        fly = SKSpriteNode(texture: flyTexture1)
         
         fly.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        fly.zPosition = 1
         
         
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
