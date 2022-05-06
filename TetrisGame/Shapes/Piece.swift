//
//  TetrisBlock.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/22/22.
//

import SpriteKit

/**
 Generates a PIece SKNode with the given shape composed of blocks
 */
class Piece : SKNode {
    
    var shape: Shape {
        didSet {
            shape.replaceBlocks(in: self)
        }
    }
    
    var size: (x: Int, y: Int) {
        shape.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(shape: Shape) {
        self.shape = shape
        super.init()
        shape.replaceBlocks(in: self)
    }
    
    func maxX(piece: Piece, coord: CGPoint) -> CGFloat {
        return coord.x + CGFloat((piece.size.x+1) * blockSize)
    }
    
    func maxY(piece: Piece, coord: CGPoint) -> CGFloat {
        return  coord.y + CGFloat((piece.size.y+1) * blockSize)
    }
}
