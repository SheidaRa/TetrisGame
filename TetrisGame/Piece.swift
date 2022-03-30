//
//  TetrisBlock.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/22/22.
//

import SpriteKit

class Piece : SKNode{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        let ltetris = [
            (0,0),
            (0,1),
            (1,0),
            (1,1)
        ]
        
        let piece = AssembleBlockChoice(structurePos: ltetris, fillColor: SKColor.gray, lineColor: SKColor.red, lineWidth: pieceLineW)
        addChild(piece)
    }
}
