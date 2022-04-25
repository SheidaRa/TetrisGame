//
//  TetrisBlock.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/22/22.
//

import SpriteKit

let squareShape = [
    (0,0),
    (0,1),
    (1,0),
    (1,1)
].map(GridPoint.init)

let zShape = [
    (1,0), (2,0),
    (1,1),
    (1,2), (0,2)
].map(GridPoint.init)

let cornerShape = [
    (1,0),
    (1,1),
    (1,2), (2,2), (3,2)
].map(GridPoint.init)

let pShape = [
//    (0,0),
//    (0,1),(1,1),
//    (0,2),(1,2)
    (0,0), (1,0),
    (0,1), (1,1), (2,1)
].map(GridPoint.init)

let uShape = [
    (0,0),(1,0), (2,0),
    (0,1),(2,1)
].map(GridPoint.init)

let tShape = [
    (1,0),
    (1,1),
    (1,2), (0,2),(2,2)
].map(GridPoint.init)

let wShape = [
    (0,0),
    (1,0), (1,1),
    (2,1), (2,2)
].map(GridPoint.init)

let stairShape = [ //not sure what shape this is?

//    (1,0),
//    (1,1),
//    (0,1),(0,2)

    (2,0),
    (2,1), (1,1),
    (1,2), (0,2)

].map(GridPoint.init)

let bomrangLShape = [
    (0,0),
    (0,1), (1,2),
    (0,2),(2,2)
].map(GridPoint.init)

let longLShape = [
    (0,0),
    (0,1),(0,3),
    (0,2),(1,0)
].map(GridPoint.init)

let idkShape = [
    (1,0),
    (0,0),
    (2,0),(1,1)
].map(GridPoint.init)

let trailShape = [
    (0,0),
    (0,1),(0,3),
    (0,2),(0,4)
].map(GridPoint.init)

let plusShape = [
    (1,0),
    (1,1),(2,1),
    (1,2),(0,1)
].map(GridPoint.init)

let longzShape = [
    (0,0),
    (1,0),(1,2),
    (1,1),(2,2)
].map(GridPoint.init)

let longStairShape = [
    (1,0),
    (1,1),(0,2),
    (1,2),(0,3)
].map(GridPoint.init)

let idk2Shape = [
    (0,0),
    (1,0),(1,1),
    (1,-1),(2,1)
].map(GridPoint.init)

let trailJumpShape = [
    (1,0),
    (1,1),(1,3),
    (1,2),(0,2)
].map(GridPoint.init)


class Piece : SKNode {
    
    let shape: Shape
    
    var size: (x: Int, y: Int) { //size isn't updated when rotated
        shape.size
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structure: [GridPoint], blockColor: String) {
        self.shape = Shape(layout: structure, image: blockColor)
//        size = shape.size
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
