//
//  HomeScene.swift
//  TetrisGame
//
//  Created by Sheida Rashidi Ardestani on 4/26/22.
//

import SpriteKit


class HomeScene: SKScene {
    
    var buttonImage = SKSpriteNode()
    
    override func didMove(to view:SKView){
        
        let background = SKSpriteNode(imageNamed: "TetrisBackground")
        background.size = CGSize(width: 375, height: 1000)
        background.anchorPoint = CGPoint.zero
        self.addChild(background)

        let title = SKSpriteNode(
        texture: SKTexture(
                    image: UIImage(named: "Title")!))
        title.position = CGPoint(x: size.width * 0.5, y: size.height * 0.83)
        title.zPosition = 1
        title.setScale(0.4)
        addChild(title)
        
        let logo = SKSpriteNode(
        texture: SKTexture(
                    image: UIImage(named: "MainImg")!))
        logo.zPosition = 1
        logo.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        logo.setScale(0.3)
        addChild(logo)
        
        let homeStartB = SKSpriteNode(
            texture: SKTexture(
                        image: UIImage(named: "StartB")!))
        homeStartB.zPosition = 1
        homeStartB.position = CGPoint(x: size.width * 0.5, y: size.height * 0.2)
        let buttonAnimate = SKAction.sequence([SKAction.fadeIn(withDuration: 0.6), SKAction.wait(forDuration: 0.5), SKAction.fadeOut(withDuration: 0.5)])
        addChild(homeStartB)
        homeStartB.setScale(0.37)
        homeStartB.run(SKAction.repeatForever(buttonAnimate))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
        
    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            let touchedNode = atPoint(convertPoint(fromView: tap.location(in: self.view)))
            let game = GameScene(size: size, levelIndex: 0)
            game.scaleMode = .aspectFit
            self.view?.presentScene(game, transition: SKTransition.moveIn(with: SKTransitionDirection.down, duration: 0.5))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    func InButtonArea (touchedNode: SKNode) -> Bool {
        if ( touchedNode.position.x <= buttonImage.position.x
             &&
             touchedNode.position.x >= buttonImage.position.x
             &&
             touchedNode.position.y <= buttonImage.position.y
             &&
             touchedNode.position.y >= buttonImage.position.y
        ) {
            return true
        } else {
            return false
        }
    }
}

 
