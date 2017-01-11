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
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ball.physicsBody?.applyImpulse(CGVector(dx: 190, dy: 190))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        player = self.childNode(withName: "Player") as! SKSpriteNode
        computer = self.childNode(withName: "Computer") as! SKSpriteNode

        
        
       
    }
    
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        if playerWhoWon == self.player {
//          score[0] += 1
            
            self.ball.physicsBody?.applyImpulse(CGVector(dx: 190, dy: 190))
            }
        else if playerWhoWon == self.computer {
//            score[1] += 1
            self.ball.physicsBody?.applyImpulse(CGVector(dx: -190, dy: -190))
        }
        
//        topLbl.text = "\(score[1])"
//        btmLbl.text = "\(score[0])"
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
        computer.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
       
        if ball.position.y <= player.position.y - 30 {
            addScore(playerWhoWon: computer)
        }
        else if ball.position.y >= computer.position.y + 30 {
            addScore(playerWhoWon: player)
        }
    }

}
