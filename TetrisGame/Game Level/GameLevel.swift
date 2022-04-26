//
//  GameLevels.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 4/25/22.
//

import SpriteKit

class GameLevel {
    
    let levelOne : Level
    let levelTwo : Level
    let levelThree : Level
    let levelFour : Level
    
    var gameLevel: Int
    
    init (size:CGSize, level:Int) {
        self.gameLevel = level
        
        // List of pieces
        let piece1 = Piece(structure: stairShape, blockColor: "B1")
        let piece2 = Piece(structure: tShape, blockColor: "B2")
        let piece3 = Piece(structure: squareShape, blockColor: "B3")
        let piece4 = Piece(structure: pShape, blockColor: "B4")
        let piece5 = Piece(structure: uShape, blockColor: "B5")
        let piece6 = Piece(structure: wShape, blockColor: "B6")
        let piece7 = Piece(structure: bomrangLShape, blockColor: "B7")
        let piece8 = Piece(structure: longLShape, blockColor: "B8")
        let piece9 = Piece(structure: idkShape, blockColor: "B9")
        let piece10 = Piece(structure: trailShape, blockColor: "B10")
        let piece11 = Piece(structure: plusShape, blockColor: "B11")
        let piece12 = Piece(structure: longzShape, blockColor: "B12")
        let piece13 = Piece(structure: longStairShape, blockColor: "B13")
        let piece14 = Piece(structure: idk2Shape, blockColor: "B14")
        let piece15 = Piece(structure: trailJumpShape, blockColor: "B15")
        
        // List of templates
        let template1 = Template(structure: t1)
        let template2 = Template(structure: t2)
        let template3 = Template(structure: t3)
        let template4 = Template(structure: t4)
        
        // Game levels
        levelOne = Level(pieces: [[piece1, piece2, piece3, piece4, piece6]], template: template3)
        levelTwo = Level(pieces: [[piece4, piece5, piece6, piece7, piece8]], template: template1)
        levelThree = Level(pieces: [[piece9, piece11, piece3, piece4, piece15]], template: template2)
        levelFour = Level(pieces: [[piece10, piece12, piece13, piece14, piece6]], template: template4)
    }
    
    func loadGameSet ()  -> Level {
        if gameLevel == 1 {
            return levelOne
        }
        else if gameLevel == 2 {
            return levelTwo
        }
        else if gameLevel == 3 {
            return levelThree
        }
        else {
            return levelFour
        }
    }
    
}
