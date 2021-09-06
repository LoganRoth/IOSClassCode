//
//  GameScene.swift
//  AngryBirdsClone
//
//  Created by Logan Roth on 2021-01-07.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false
    
    var origPos : CGPoint?
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType : UInt32 {
        case Bird = 1
        case Box = 2
        case Ground = 4
        case Tree = 8
    }
    
    override func didMove(to view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
        bird = childNode(withName: "bird") as! SKSpriteNode
        let birdText = SKTexture(imageNamed: "bird")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdText.size().height * 0.08)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.5
        origPos = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue

        
        let boxText = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxText.size().width * 0.13, height: boxText.size().height * 0.13)
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.4
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.4
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.4
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.4
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.4
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height * 0.25)
        self.addChild(scoreLabel)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue
            || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            score += 1
            scoreLabel.text = String(score)
        }
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                let touchLoc = touch.location(in: self)
                let touchNodes = nodes(at: touchLoc)
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLoc
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                let touchLoc = touch.location(in: self)
                let touchNodes = nodes(at: touchLoc)
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                let xDiff = -(touchLoc.x - origPos!.x)
                                let yDiff = -(touchLoc.y - origPos!.y)
                                let impulse = CGVector(dx: xDiff, dy: yDiff)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let birdPhys = bird.physicsBody {
            if birdPhys.velocity.dx <= 0.1 && birdPhys.velocity.dy <= 0.1 && birdPhys.angularVelocity <= 0.1 && gameStarted == true {
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.position = origPos!
                bird.zPosition = 1
                
                gameStarted = false
            }
        }
    }
}
