//
//  GameLevel.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 4/25/22.
//

import Foundation

struct Level {
    
    let shapes: [Shape]
    let template: Template
    
    init(shapes: [Shape], template: [GridPoint]){
        self.template = Template(structure: template)
        self.shapes = shapes
    }
}
