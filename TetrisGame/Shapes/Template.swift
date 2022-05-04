//
//  Template.swift
//  TetrisGame
//
//  Created by Lily Ewing on 3/24/22.
//

import SpriteKit

class Template : SKNode {
    
    let size: (x: Int, y: Int)
    
    let shape: Shape
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structure: [GridPoint]) {
        size = (
            structure.map(\.x).max() ?? 0,
            structure.map(\.y).max() ?? 0
        )
        
        shape = Shape(structure: structure, blockImage: "templateBlock")
        
        super.init()

        shape.replaceBlocks(in: self)
    }
    
    
}
   
