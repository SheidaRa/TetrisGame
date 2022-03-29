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

        let template = TemplateOutline()
        //template.position = CGPoint(x:size/2, y: size/2)
        self.addChild(template)

        let tetris = Piece()
        tetris.position = CGPoint(x: 150, y: 150)
        self.addChild(tetris)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let curTouchPos = touch.location(in: self)
            let prevTouchPos = touch.previousLocation(in: self)

            let touchedNode = atPoint(prevTouchPos)
            if let touchedBlock = touchedNode.parent?.parent as? Piece { //
                touchedBlock.position += curTouchPos - prevTouchPos
            }
        }
    }
}
