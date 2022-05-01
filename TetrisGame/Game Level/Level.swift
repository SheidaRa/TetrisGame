//
//  GameLevel.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 4/25/22.
//

import Foundation

class Level {
    
    let pieces: [Piece]
    let template: Template
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(pieces: [Piece], template: [GridPoint]){
        self.template = Template(structure: template)
        self.pieces = pieces
    }
    
}
