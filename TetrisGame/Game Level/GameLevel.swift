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
        piece1.position = CGPoint(x: 80, y: 150)
        piece1.zPosition = 1
        
        let piece2 = Piece(structure: tShape, blockColor: "B2")
        piece2.position = CGPoint(x: 0, y: 150)
        piece2.zPosition = 1

        let piece3 = Piece(structure: squareShape, blockColor: "B3")
        piece3.position = CGPoint(x: 50, y: 50)
        piece3.zPosition = 1

        let piece4 = Piece(structure: pShape, blockColor: "B4")
        piece4.position = CGPoint(x: 220, y: 150)
        piece4.zPosition = 1

        let piece5 = Piece(structure: uShape, blockColor: "B5")
        piece5.position = CGPoint(x: 180, y: 20)
        piece5.zPosition = 1
        
        let piece6 = Piece(structure: wShape, blockColor: "B6")
        piece6.position = CGPoint(x: 60, y: 30)
        piece6.zPosition = 1
        
        let piece7 = Piece(structure: bomrangLShape, blockColor: "B7")
        piece7.position = CGPoint(x: 60, y: 30)
        piece7.zPosition = 1

        let piece8 = Piece(structure: longLShape, blockColor: "B8")
        piece8.position = CGPoint(x: 60, y: 30)
        piece8.zPosition = 1

        let piece9 = Piece(structure: idkShape, blockColor: "B9")
        piece9.position = CGPoint(x: 60, y: 30)
        piece9.zPosition = 1

        let piece10 = Piece(structure: trailShape, blockColor: "B10")
        piece10.position = CGPoint(x: 60, y: 30)
        piece10.zPosition = 1

        let piece11 = Piece(structure: plusShape, blockColor: "B11")
        piece11.position = CGPoint(x: 60, y: 30)
        piece11.zPosition = 1

        let piece12 = Piece(structure: longzShape, blockColor: "B12")
        piece12.position = CGPoint(x: 60, y: 30)
        piece12.zPosition = 1

        let piece13 = Piece(structure: longStairShape, blockColor: "B13")
        piece13.position = CGPoint(x: 60, y: 30)
        piece13.zPosition = 1

        let piece14 = Piece(structure: idk2Shape, blockColor: "B14")
        piece14.position = CGPoint(x: 60, y: 30)
        piece14.zPosition = 1

        let piece15 = Piece(structure: trailJumpShape, blockColor: "B15")
        piece15.position = CGPoint(x: 60, y: 30)
        piece15.zPosition = 1
        
        // List of templates
        let template1 = Template(structure: t1)
        let template2 = Template(structure: t2)
        let template3 = Template(structure: t3)
        let template4 = Template(structure: t4)
        
        // Game levels
        levelOne = Level(pieces: [[piece1, piece2, piece3, piece4, piece6]], template: template2)
        levelTwo = Level(pieces: [[piece1, piece2, piece3, piece4, piece6]], template: template2)
        levelThree = Level(pieces: [[piece1, piece2, piece3, piece4, piece6]], template: template2)
        levelFour = Level(pieces: [[piece1, piece2, piece3, piece4, piece6]], template: template2)
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
