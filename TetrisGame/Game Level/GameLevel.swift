//
//  GameLevels.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 4/25/22.
//

import SpriteKit

let shape1 = Shape(structure: stairShape, blockImage: "B1")
let shape2 = Shape(structure: tShape, blockImage: "B2")
let shape3 = Shape(structure: squareShape, blockImage: "B3")
let shape4 = Shape(structure: pShape, blockImage: "B4")
let shape4b = Shape(structure: pShape, blockImage: "B15")
let shape5 = Shape(structure: uShape, blockImage: "B5")
let shape6 = Shape(structure: wShape, blockImage: "B6")
let shape7 = Shape(structure: bomrangLShape, blockImage: "B7")
let shape7b = Shape(structure: bomrangLShape, blockImage: "B13")
let shape8 = Shape(structure: longLShape, blockImage: "B8")
let shape9 = Shape(structure: idkShape, blockImage: "B9")
let shape10 = Shape(structure: trailShape, blockImage: "B4")
let shape11 = Shape(structure: plusShape, blockImage: "B11")
let shape12 = Shape(structure: longzShape, blockImage: "B12")
let shape13 = Shape(structure: longStairShape, blockImage: "B3")
let shape14 = Shape(structure: idk2Shape, blockImage: "B14")
let shape15 = Shape(structure: trailJumpShape, blockImage: "B1")


let allLevels: [Level] = [
    //Intro
    Level(shapes: [shape5, shape11, shape4], template: tstart),
    Level(shapes: [shape3, shape12], template: t0),

    //5 shapes
    Level(shapes: [shape1, shape2, shape3, shape4, shape5], template: t3),
    Level(shapes: [shape14, shape7, shape8, shape13.flipped(), shape12.flipped()], template: t9),

    //6 shapes
    Level(shapes: [shape7, shape12, shape4, shape14, shape9, shape13], template: t2),
    Level(shapes: [shape5, shape15, shape14, shape13, shape8, shape10], template: t7),

    //7 shapes
    Level(shapes: [shape14, shape12.flipped(), shape7.flipped(), shape2, shape4, shape8.flipped(), shape5], template: t4),
    Level(shapes: [shape13, shape1.flipped(), shape4, shape7, shape15.flipped(), shape7b, shape9], template: t5),
    Level(shapes: [shape4, shape4b, shape11, shape12.flipped(), shape5, shape8.flipped(), shape3], template: t8),
    Level(shapes: [shape15, shape8, shape11, shape5, shape10, shape13, shape14], template: t1),
]
