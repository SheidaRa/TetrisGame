//
//  GameLevels.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 4/25/22.
//

import SpriteKit

class GameLevel {
    
    let levelOne: Level
    let levelTwo: Level
    let levelThree: Level
    let levelFour: Level
    let levelFive: Level
    let levelSix: Level
    let levelSeven: Level
    let levelEight: Level
    let levelNine: Level
    
    var gameLevel: Int
    
    init (size:CGSize, level:Int) {
        self.gameLevel = level
        
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
        
        // List of templates
        let template1 = Template(structure: t1)
        let template2 = Template(structure: t2)
        let template3 = Template(structure: t3)
        let template4 = Template(structure: t4)
        let template5 = Template(structure: t5)
        let template6 = Template(structure: t6)
        let template7 = Template(structure: t7)
        let template8 = Template(structure: t8)
        let template9 = Template(structure: t9)
        
        // Game levels
        levelOne = Level(pieces: [piece1, piece2, piece3, piece4, piece5], template: template3)
        levelTwo = Level(pieces: [piece7, piece12, piece4, piece14, piece9, piece13], template: template2)
        levelThree = Level(pieces: [piece15, piece11, piece8, piece5, piece10, piece14, piece13], template: template1)
        levelFour = Level(pieces: [piece8, piece14, piece5, piece12, piece7, piece2, piece4], template: template4)
        levelFive = Level(pieces: [piece13, piece1, piece4, piece7, piece9, piece15, piece7b], template: template5)
        levelSix = Level(pieces: [piece14, piece5, piece9, piece12, piece10, piece15, piece8, piece13], template: template6)
        levelSeven = Level(pieces: [piece5, piece14, piece13, piece15, piece8, piece10], template: template7)
        levelEight = Level(pieces: [piece4, piece3, piece11, piece12, piece5, piece8, piece4b], template: template8)
        levelNine = Level(pieces: [piece7, piece8, piece12, piece14, piece13], template: template9)
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
        else if gameLevel == 4{
            return levelFour
        }
        else if gameLevel == 5{
            return levelFive
        }
        else if gameLevel == 6{
            return levelSix
        }
        else if gameLevel == 7{
            return levelSeven
        }
        else if gameLevel == 8{
            return levelEight
        }
        else if gameLevel == 9{
            return levelNine
        }
        else {
            return levelSix
        }
    }
    
}
