//
//  GameLevels.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 4/25/22.
//

import SpriteKit

// List of pieces
let piece1 = Piece(structure: stairShape, blockColor: "B1")
let piece2 = Piece(structure: tShape, blockColor: "B2")
let piece3 = Piece(structure: squareShape, blockColor: "B3")
let piece4 = Piece(structure: pShape, blockColor: "B4")
let piece4b = Piece(structure: pShape, blockColor: "B15")
let piece5 = Piece(structure: uShape, blockColor: "B5")
let piece6 = Piece(structure: wShape, blockColor: "B6")
let piece7 = Piece(structure: bomrangLShape, blockColor: "B7")
let piece7b = Piece(structure: bomrangLShape, blockColor: "B13")
let piece8 = Piece(structure: longLShape, blockColor: "B8")
let piece9 = Piece(structure: idkShape, blockColor: "B9")
let piece10 = Piece(structure: trailShape, blockColor: "B4")
let piece11 = Piece(structure: plusShape, blockColor: "B11")
let piece12 = Piece(structure: longzShape, blockColor: "B12")
let piece13 = Piece(structure: longStairShape, blockColor: "B3")
let piece14 = Piece(structure: idk2Shape, blockColor: "B14")
let piece15 = Piece(structure: trailJumpShape, blockColor: "B1")



let introLvl: Level = Level(pieces: [piece5, piece11, piece4], template: tstart)
let lvl0: Level = Level(pieces: [piece3, piece12], template: t0)
let lvl1: Level = Level(pieces: [piece1, piece2, piece3, piece4, piece5], template: t3)
let lvl2: Level = Level(pieces: [piece7, piece12, piece4, piece14, piece9, piece13], template: t2)
let lvl3: Level = Level(pieces: [piece15, piece11, piece8, piece5, piece10, piece14, piece13], template: t1)
let lvl4: Level = Level(pieces: [piece8, piece14, piece5, piece12, piece7, piece2, piece4], template: t4)
let lvl5: Level = Level(pieces: [piece13, piece1, piece4, piece7, piece9, piece15, piece7b], template: t5)
let lvl6: Level = Level(pieces: [piece14, piece5, piece9, piece12, piece10, piece15, piece8, piece13], template: t6)
let lvl7: Level = Level(pieces: [piece5, piece14, piece13, piece15, piece8, piece10], template: t7)
let lvl8: Level = Level(pieces: [piece4, piece3, piece11, piece12, piece5, piece8, piece4b], template: t8)
let lvl9: Level = Level(pieces: [piece7, piece8, piece12, piece14, piece13], template: t9)

let allLevels: [Level] = [introLvl, lvl1, lvl2, lvl3, lvl4, lvl5, lvl6, lvl7, lvl8, lvl9]
