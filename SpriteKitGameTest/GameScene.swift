//
//  GameScene.swift
//  SpriteKitGameTest
//
//  Created by Wttch on 2022/7/6.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var player: SKShapeNode?
    private var spinnyNode: SKShapeNode?
    
        
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -10, y: 0))
        path.addLine(to: CGPoint(x: 10, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 40))
        path.addLine(to: CGPoint(x: 0, y: 200))
        path.addLine(to: CGPoint(x: 0, y: 40))
        path.addLine(to: CGPoint(x: -10, y: 0))
        self.player = SKShapeNode.init(path: path)
        if let player = self.player {
            player.lineWidth = 2
            player.fillColor = .systemPink
            self.addChild(player)
        }
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        self.camera = self.childNode(withName: "//mainCamera") as? SKCameraNode
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
        if let player = self.player {
            let dx = (pos.x - player.position.x)
            let dy = (pos.y - player.position.y)
            let angle = atan(dy / dx)
            print(dx, dy, dy / dx, angle)
            if dx > 0 {
                var a = angle - .pi / 2
                player.run(SKAction.sequence([SKAction.rotate(toAngle: a, duration: 1, shortestUnitArc: true)]))
            } else {
                var a = angle + .pi / 2
                player.run(SKAction.sequence([SKAction.rotate(toAngle: angle + .pi / 2, duration: 1, shortestUnitArc: true)]))
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.systemPink
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31:
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    override func keyUp(with event: NSEvent) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
//        if let player = self.player {
//            player.position = CGPoint(x: player.position.x + 0.1, y: player.position.y + 0.2)
//        }
//        if let camera = self.camera {
//            camera.position = CGPoint(x: camera.position.x + 0.1, y: camera.position.y + 0.2)
//        }
    }
}
