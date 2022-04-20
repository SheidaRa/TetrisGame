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
    (1,1)]

let zShape = [
    (1,0), (2,0),
    (1,1),
    (1,2), (0,2)]

let cornerShape = [
    (1,0),
    (1,1),
    (1,2), (2,2), (3,2)]

let pShape = [
    (0,0),
    (0,1),(1,1),
    (0,2),(1,2)]

let uShape = [
    (0,0),(1,0), (2,0),
    (0,1),(2,1)]

let tShape = [
    (0,0),
    (0,1),
    (0,2), (-1,2),(1,2)]

let wShape = [
    (0,0),
    (1,0), (1,1),
    (2,1), (2,2)]

let stairShape = [
    (0,0),
    (0,1),
    (-1,1),(-1,2)]

let bomrangLShape = [
    (0,0),
    (0,1), (1,2),
    (0,2),(2,2),]

let longLShape = [
    (0,0),
    (0,1),(0,3),
    (0,2),(1,0),]

let idkShape = [
    (0,0),
    (-1,0),
    (1,0),(0,1),]

let trailShape = [
    (0,0),
    (0,1),(0,3),
    (0,2),(0,4),]

let plusShape = [
    (0,0),
    (-1,0),(0,1),
    (1,0),(0,-1),]

let longzShape = [
    (0,0),
    (0,-1),(0,1),
    (1,-1),(-1,1),]

let longStairShape = [
    (0,0),
    (0,1),(-1,2),
    (0,2),(-1,3),]

let idk2Shape = [
    (0,0),
    (1,0),(1,1),
    (1,-1),(2,1),]

let trailJumpShape = [
    (0,0),
    (0,1),(0,3),
    (0,2),(-1,2),]





class Piece : SKNode {
    
    let shape: Shape
    
    var size: (x: Int, y: Int) { //size isn't updated when rotated
        shape.size
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structure: [(Int, Int)], blockColor: String) {
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
