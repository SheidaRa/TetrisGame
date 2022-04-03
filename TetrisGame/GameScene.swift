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

        let template = TemplateOutline(structure: t3)
        template.position = CGPoint(x: size.width/5, y: size.height/2) //puts template in front of pieces
        template.zPosition = 0
        self.addChild(template)

        let piece1 = Piece(structure: stairShape, blockColor: "redBlock")
        piece1.position = CGPoint(x: 100, y: 150)
        piece1.zPosition = 1
        addChild(piece1)
        
        let piece2 = Piece(structure: tShape, blockColor: "blueBlock")
        piece2.position = CGPoint(x: 0, y: 150)
        piece2.zPosition = 1
        self.addChild(piece2)

        let piece3 = Piece(structure: squareShape, blockColor: "yellowBlock")
        piece3.position = CGPoint(x: 50, y: 50)
        piece3.zPosition = 1
        self.addChild(piece3)

        let piece4 = Piece(structure: pShape, blockColor: "purpleBlock")
        piece4.position = CGPoint(x: 235, y: 150)
        piece4.zPosition = 1
        self.addChild(piece4)

        let piece5 = Piece(structure: uShape, blockColor: "greenBlock")
        piece5.position = CGPoint(x: 180, y: 20)
        piece5.zPosition = 1
        self.addChild(piece5)
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
