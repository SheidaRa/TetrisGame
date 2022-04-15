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
    (1,0),
    (1,1),
    (0,2), (1,2),(2,2)]

let stairShape = [
    (2,0),
    (2,1), (1,1),
    (1,2), (0,2)]

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
}
