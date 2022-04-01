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

//        let template = TemplateOutline(structure: t3)
//        template.position = CGPoint(x: 100, y: 200)
//        self.addChild(template)

        let piece1 = Piece(structure: stairShape)
        piece1.position = CGPoint(x: 100, y: 150)
        self.addChild(piece1)
        
//        let piece2 = Piece(structure: tShape)
//        piece2.position = CGPoint(x: 200, y: 150)
//        self.addChild(piece2)
//
//        let piece3 = Piece(structure: squareShape)
//        piece3.position = CGPoint(x: 250, y: 150)
//        self.addChild(piece3)
//
//        let piece4 = Piece(structure: pShape)
//        piece4.position = CGPoint(x: 300, y: 150)
//        self.addChild(piece4)
//
//        let piece5 = Piece(structure: uShape)
//        piece5.position = CGPoint(x: 250, y: 50)
//        self.addChild(piece5)
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
