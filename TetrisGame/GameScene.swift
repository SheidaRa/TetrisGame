//
//  GameScene.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/16/22.
//

import SpriteKit

class GameScene: SKScene {

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override init(size: CGSize) {
      super.init(size: size)
        let tetris = TetrisBlock()
        tetris.position = CGPoint(x: 150, y: 150)
        self.addChild(tetris)
        
//        let template = TemplateOutline(size: size)
//        self.addChild(template)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let curTouchPos = touch.location(in: self)
            let prevTouchPos = touch.previousLocation(in: self)

            let touchedNode = atPoint(prevTouchPos)
            if let touchedBlock = touchedNode.parent as? TetrisBlock {
                touchedBlock.position += curTouchPos - prevTouchPos
            }
        }
    }
}
