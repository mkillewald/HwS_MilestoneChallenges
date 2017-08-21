//
//  GameScene.swift
//  Milestone8
//
//  Created by Mike Killewald on 8/11/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var rowTimer: Timer!
    var alienTimer: Timer!
    var roundTimer: Timer!
    
    var targets = [SKNode]()
    
    let badGuys = ["alienR2L", "alienL2R", "borg", "cowboy", "geek", "ninja", "pirate"]
    
    let leftEdge = -50
    let rightEdge = 1024 + 50
    let row1Pos = 100
    let row2Pos = 215
    let row3Pos = 310
    let alienPos = 680
    
    var gameScore: SKLabelNode!
    var score: Int = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    // timeLeft starts with 1 extra "hidden" second so it doesn't start counting down before any characters actually appear on the screen.
    var timeLeftLabel: SKLabelNode!
    var timeLeft: Int = 61 {
        didSet {
            if timeLeft < 60 {
                timeLeftLabel.text = "Time: \(timeLeft)"
            }
        }
    }
    
    var roundsLaunched = 0
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 722)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        timeLeftLabel = SKLabelNode(fontNamed: "Chalkduster")
        timeLeftLabel.text = "Time: 60"
        timeLeftLabel.position = CGPoint(x: 750, y: 722)
        timeLeftLabel.horizontalAlignmentMode = .left
        timeLeftLabel.fontSize = 48
        addChild(timeLeftLabel)
        
        // set a 3 second delay before starting the game after the game (app) is launched
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(startGame), userInfo: nil, repeats: false)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        for (index, target) in targets.enumerated().reversed() {
            if let name = target.name {
                if Int(target.position.y) == row1Pos && Int(target.position.x) == rightEdge {
                    if badGuys.contains(name) {
                        score -= 5
                    }
                    
                    targets.remove(at: index)
                    target.removeFromParent()
                } else if Int(target.position.y) == row2Pos && Int(target.position.x) == leftEdge {
                    if badGuys.contains(name) {
                        score -= 10
                    }
                    
                    targets.remove(at: index)
                    target.removeFromParent()
                } else if Int(target.position.y) == row3Pos && Int(target.position.x) == rightEdge {
                    if badGuys.contains(name) {
                        score -= 15
                    }
                    
                    targets.remove(at: index)
                    target.removeFromParent()
                } else if name == "alienL2R" && Int(target.position.x) == rightEdge {
                    score -= 100
                    
                    targets.remove(at: index)
                    target.removeFromParent()
                } else if name == "alienR2L" && Int(target.position.x) == leftEdge {
                    score -= 100
                    
                    targets.remove(at: index)
                    target.removeFromParent()
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        checkTouches(touches)
    }
    
    func checkTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        var characterWasTapped = false
        
        for node in nodesAtPoint {
            if node is SKSpriteNode {
                if let name = node.name {
                    characterWasTapped = true
                    if badGuys.contains(name) {
                        node.name = "hit"
                        
                        let fade = SKAction.fadeOut(withDuration: 0.25)
                        let shrink = SKAction.scale(to: 0.0, duration: 0.25)
                        let fadeShrink = SKAction.group([fade, shrink])
                        node.run(fadeShrink)
                        
                        switch(Int(node.position.y)){
                        case row1Pos:
                            score += 25
                        case row2Pos:
                            score += 50
                        case row3Pos:
                            score += 100
                        case alienPos:
                            score += 500
                        default:
                            break
                        }
                    } else {
                        if node.name == "hit" || node.name == "miss" { return }  // handles cases where multiple taps are registered
                        
                        node.name = "miss"
                        let redX = SKSpriteNode(imageNamed: "X-icon")
                        redX.zPosition = 400
                        
                        let redXFadeOut = SKAction.fadeOut(withDuration: 0.75)
                        redX.run(redXFadeOut)
                        
                        node.addChild(redX)
                        
                        switch(Int(node.position.y)){
                        case row1Pos:
                            score -= 50
                        case row2Pos:
                            score -= 100
                        case row3Pos:
                            score -= 300
                        default:
                            break
                        }
                    }
                }
            }
        }
        
        // if touch was a miss, deduct points. needs way of debouncing multiple hits
        if !characterWasTapped {
            score -= 100
        }
    }
    
    func startGame() {
        rowTimer = Timer.scheduledTimer(timeInterval: 1.75, target: self, selector: #selector(launchRowTargets), userInfo: nil, repeats: true)
        alienTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(launchAlienTarget), userInfo: nil, repeats: true)
        roundTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)
    }
    
    func randomTarget() -> String {
        let target: String
        let randomInt = GKRandomSource.sharedRandom().nextInt(upperBound: 10)  // generates random integer from 0-9
    
        switch(randomInt) {
        case 0:
            target = "borg"
        case 1:
            target = "cowboy"
        case 2:
            target = "geek"
        case 3:
            target = "geisha"
        case 4:
            target = "girl"
        case 5:
            target = "nurse"
        case 6:
            target = "ninja"
        case 7:
            target = "princess"
        case 8:
            target = "candy"
        default:
            target = "pirate" // will be used when randomInt = 9
        }
        
        return target
    }
    
    func launchRowTargets() {
        var target: String
        
        // row 1
        target = randomTarget()
        let targetRow1 = SKSpriteNode(imageNamed: target)
        targetRow1.name = target
        targetRow1.position = CGPoint(x: leftEdge, y: row1Pos)           // start offscreen at left edge
        targetRow1.zPosition = 300                              // keep sprite on top
        let moveRow1 = SKAction.moveTo(x: CGFloat(rightEdge), duration: 6.0)  // move left to right
        
        // row 2
        target = randomTarget()
        let targetRow2 = SKSpriteNode(imageNamed: target)
        targetRow2.name = target
        targetRow2.position = CGPoint(x: rightEdge, y: row2Pos)          // start offscreen at right edge
        targetRow2.xScale = -0.9                                // flip image on x and scale image 90%
        targetRow2.yScale = 0.9                                 // scale image 90%
        targetRow2.zPosition = 300                              // keep sprite on top
        let moveRow2 = SKAction.moveTo(x: CGFloat(leftEdge), duration: 5.0)   // move right to left
        
        // row 3
        target = randomTarget()
        let targetRow3 = SKSpriteNode(imageNamed: target)
        targetRow3.name = target
        targetRow3.position = CGPoint(x: leftEdge, y: row3Pos)           // start offscreen at left edge
        targetRow3.xScale = 0.8                                 // scale image 80%
        targetRow3.yScale = 0.8                                 // scale image 80%
        targetRow3.zPosition = 300                              // keep sprite on top
        let moveRow3 = SKAction.moveTo(x: CGFloat(rightEdge), duration: 4.5)  // move left to right
        
        targetRow1.run(moveRow1)
        targetRow2.run(moveRow2)
        targetRow3.run(moveRow3)
        
        addChild(targetRow1)
        addChild(targetRow2)
        addChild(targetRow3)
        
        targets.append(targetRow3)
        targets.append(targetRow2)
        targets.append(targetRow1)
    }
    
    func launchAlienTarget() {
        let alien = SKSpriteNode(imageNamed: "alien-noShadow")
        let moveAlien: SKAction
        
        switch(GKRandomSource.sharedRandom().nextInt(upperBound: 2)) {
        case 0:
            alien.position = CGPoint(x: rightEdge, y: alienPos)
            moveAlien = SKAction.moveTo(x: CGFloat(leftEdge), duration: 1.5)  // move right to left
            alien.xScale = -0.7                                               // flip on x and scale image 60%
            alien.name = "alienR2L"
        default:
            alien.position = CGPoint(x: leftEdge, y: alienPos)
            moveAlien = SKAction.moveTo(x: CGFloat(rightEdge), duration: 1.5)  // move left to right
            alien.xScale = 0.7                                                 // flip on x and scale// flip on x and scale
            alien.name = "alienL2R"
        }
        
        alien.yScale = 0.7
        alien.zPosition = 300
        
        alien.run(moveAlien)
        addChild(alien)
        targets.append(alien)
    }
    
    func decreaseTimer() {
        timeLeft -= 1
        
        if timeLeft == 0 {
            rowTimer.invalidate()
            alienTimer.invalidate()
            roundTimer.invalidate()
            
            Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(gameOver), userInfo: nil, repeats: false)
        }
    }
    
    func gameOver() {
        let gameOver = SKSpriteNode(imageNamed: "gameOver")
        gameOver.position = CGPoint(x: 512, y: 384)
        gameOver.zPosition = 999
        
        addChild(gameOver)
    }
}
