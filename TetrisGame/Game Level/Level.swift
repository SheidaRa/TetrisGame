//
//  GameLevel.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 4/25/22.
//

import Foundation

struct Level: Hashable {
    var pieces: [[Piece]]
    var template: Template
}
