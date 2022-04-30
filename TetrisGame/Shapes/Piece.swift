//
//  TetrisBlock.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/22/22.
//

import SpriteKit

class Piece : SKNode {
    
    let shape: Shape
    
    var size: (x: Int, y: Int) {
        shape.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structure: [GridPoint], blockColor: String) {
        self.shape = Shape(layout: structure, image: blockColor)
        super.init()
        addChild(shape)
    }
    func maxX(piece: Piece, coord: CGPoint) -> CGFloat {
        return coord.x + CGFloat((piece.size.x+1) * blockSize)
    }
    
    func maxY(piece: Piece, coord: CGPoint) -> CGFloat {
        return  coord.y + CGFloat((piece.size.y+1) * blockSize)
    }
}
