//
//  GameScene.swift
//  Flypi Fly - SpriteKit
//
//  Created by Ezequiel Parada Beltran on 02/08/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum tipoNodo: UInt32 {
        case mosca = 1
        case ground = 2
        case spaceTubes = 4
    }
    
    
    var fly = SKSpriteNode()
    var BGImage = SKSpriteNode()
    
    var tube = SKSpriteNode()
    var tube2 = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var score = 0
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // tube timer
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.addTubesSpaces), userInfo: nil, repeats: true)
        
        
        //Score
        addScoreLabel()
        
        // Fly
              
              addFly()
              
        
        //Background
        addBackground()
        
        // Ground
        addGround()
        
        // tubes
        addTubesSpaces()
        
        // spaces between tubes
        
//        addSpace()
      
       
        
       
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
        ground.physicsBody?.categoryBitMask = tipoNodo.ground.rawValue
        ground.physicsBody?.collisionBitMask = tipoNodo.mosca.rawValue
        ground.physicsBody?.contactTestBitMask = tipoNodo.mosca.rawValue
        self.addChild(ground)
        
        
    }
    
    @objc func addTubesSpaces() {
        
        let tubesMovement = SKAction.move(by: CGVector(dx: -3 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width/80))
        
        let tubesRemove = SKAction.removeFromParent()
        let moveAndRemoveTubes = SKAction.sequence([tubesMovement, tubesRemove])
        
        
        let gapDifficulty = fly.size.height * 3
        
        //Numoro entre 0 y lo mitad del alto de la pantalla
        let randomMovement = CGFloat(arc4random() % UInt32(self.frame.height/2))
        
        let compensation = randomMovement - self.frame.height / 4
        
        
        let tubeTexture = SKTexture(imageNamed: "Tubo1.png")
        let tubeTexture2 = SKTexture(imageNamed: "Tubo2.png")
        tube = SKSpriteNode(texture: tubeTexture)
        tube2 = SKSpriteNode(texture: tubeTexture2)
        
        tube.position = CGPoint(x: self.frame.width, y: self.frame.midY + tubeTexture.size().height / 2 + gapDifficulty + compensation)
        tube.zPosition = 0
        tube2.zPosition = 0
        tube2.position = CGPoint(x: self.frame.width, y: -(self.frame.midY + tubeTexture.size().height / 2) - gapDifficulty + compensation)
        
        tube.physicsBody = SKPhysicsBody(rectangleOf: tubeTexture.size())
        tube2.physicsBody = SKPhysicsBody(rectangleOf: tubeTexture2.size())
        tube.physicsBody!.isDynamic = false
        tube2.physicsBody!.isDynamic = false
        tube.physicsBody?.categoryBitMask = tipoNodo.ground.rawValue
        tube.physicsBody?.collisionBitMask = tipoNodo.mosca.rawValue
        tube.physicsBody?.contactTestBitMask = tipoNodo.mosca.rawValue
        tube2.physicsBody?.categoryBitMask = tipoNodo.ground.rawValue
        tube2.physicsBody?.collisionBitMask = tipoNodo.mosca.rawValue
        tube2.physicsBody?.contactTestBitMask = tipoNodo.mosca.rawValue
        
        tube.run(moveAndRemoveTubes)
        tube2.run(moveAndRemoveTubes)
        self.addChild(tube2)
        self.addChild(tube)
        
        // espacios
//        addSpace()
        
        
        
       
               let space = SKSpriteNode()
               
               
               space.position = CGPoint(x:self.frame.midX + self.frame.width , y:self.frame.midY + compensation)
               
               space.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:tubeTexture.size().width , height: fly.size.height * 3))
               
               space.physicsBody!.isDynamic = false
               space.zPosition = 1
               
               space.physicsBody!.categoryBitMask = tipoNodo.spaceTubes.rawValue
               space.physicsBody!.collisionBitMask = 0
               space.physicsBody!.contactTestBitMask = tipoNodo.mosca.rawValue
               
               
               space.run(moveAndRemoveTubes)
               
               
               self.addChild(space)
        
    }
    
    
    func addSpace() {
        let tubeTexture = SKTexture(imageNamed: "Tubo1.png")
        let tubesSpaceMovement = SKAction.move(by: CGVector(dx: -3 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width/80))
        
        let tubesSpaceRemove = SKAction.removeFromParent()
        let moveAndRemoveSpaceTubes = SKAction.sequence([tubesSpaceMovement, tubesSpaceRemove])
        
        let randomMovement = CGFloat(arc4random() % UInt32(self.frame.height/2))
        let compensation = randomMovement - self.frame.height / 4
        let space = SKSpriteNode()
        space.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + compensation)
        space.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tubeTexture.size().width, height: fly.size.height * 3))
        space.physicsBody?.isDynamic = false
        space.zPosition = 1
        space.physicsBody?.categoryBitMask = tipoNodo.spaceTubes.rawValue
        space.physicsBody?.collisionBitMask = 0
        space.physicsBody?.contactTestBitMask = tipoNodo.mosca.rawValue
        space.run(moveAndRemoveSpaceTubes)
        
        self.addChild(space)
        
    }
    
    func addScoreLabel() {
        scoreLabel.fontName = "Avenir"
        scoreLabel.fontSize = 80
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: (self.frame.midY + self.frame.size.height/3) )
        
        self.addChild(scoreLabel)
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
        fly.physicsBody = SKPhysicsBody(circleOfRadius: fly.frame.height/2)
        fly.physicsBody!.isDynamic = false
        fly.physicsBody?.categoryBitMask = tipoNodo.mosca.rawValue
        fly.physicsBody?.collisionBitMask = tipoNodo.ground.rawValue
        fly.physicsBody?.contactTestBitMask = tipoNodo.ground.rawValue | tipoNodo.spaceTubes.rawValue
         
        fly.run(infiniteAnimation)
         
         self.addChild(fly)
         
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
              
        fly.physicsBody!.isDynamic = true
        
        fly.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        fly.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 80))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let cuerpoA = contact.bodyA
        let cuerpoB = contact.bodyB
        
        
        if cuerpoA.categoryBitMask == tipoNodo.mosca.rawValue && cuerpoB.categoryBitMask == tipoNodo.spaceTubes.rawValue ||
            cuerpoB.categoryBitMask == tipoNodo.mosca.rawValue && cuerpoA.categoryBitMask == tipoNodo.spaceTubes.rawValue {
             score += 1
        }
        scoreLabel.text = String(score)
       
       
    }
   
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
