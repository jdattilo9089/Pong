//
//  GameScene.swift
//  Pong
//
//  Created by student3 on 12/15/16.
//  Copyright © 2016 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
   
    var ball = SKSpriteNode()
    var player = SKSpriteNode()
    var computer = SKSpriteNode()
    var timer = Timer()
    var computerLabel = SKLabelNode()
    var playerLabel = SKLabelNode()
    var playerScore = 0
    var computerScore = 0
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ball.physicsBody?.applyImpulse(CGVector(dx: 200, dy: 200))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1.05
        self.physicsBody = border
        
        player = self.childNode(withName: "Player") as! SKSpriteNode
        computer = self.childNode(withName: "Computer") as! SKSpriteNode
        
        playerLabel.fontSize = 65
        computerLabel.fontSize = 65
        computerLabel.fontName = "AmericanTypewriter-Bold"
        playerLabel.fontName = "AmericanTypewriter-Bold"
        computerLabel.position = CGPoint(x: -449.930, y: 623.454)
        playerLabel.position = CGPoint(x: -449.930, y: -616.317)
        computerLabel.text = "0"
        playerLabel.text = "0"
        
        self.addChild(computerLabel)
        self.addChild(playerLabel)
    }
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        if playerWhoWon == self.player {
            self.playerScore += 1
            self.playerLabel.text = String(self.playerScore)
            self.ball.physicsBody?.applyImpulse(CGVector(dx: 200, dy: 200))
            }
        else if playerWhoWon == self.computer {
            self.computerScore += 1
            self.computerLabel.text = String(self.computerScore)
            self.ball.physicsBody?.applyImpulse(CGVector(dx: -200, dy: -200))
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }

    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        computer.run(SKAction.moveTo(x: ball.position.x, duration: 0.105555))
       
        if ball.position.y <= player.position.y - 30 {
            addScore(playerWhoWon: computer)
        }
        else if ball.position.y >= computer.position.y + 30 {
            addScore(playerWhoWon: player)
        }
    }
}
