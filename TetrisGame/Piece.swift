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
    (1,1),(2,1), (3,1),
    (1,2),(3,2)]

let tShape = [
    (1,0),
    (1,1),
    (0,2), (1,2),(2,2)]

let stairShape = [
    (3,1),
    (3,2), (2,2),
    (2,3), (1,3)]

class Piece : SKNode{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structure : [(Int, Int)]) {
        super.init()
        let piece = AssembleBlockChoice(structurePos: structure, fillColor: SKColor.gray, lineColor: SKColor.red, lineWidth: pieceLineW)
        addChild(piece)
    }
}
