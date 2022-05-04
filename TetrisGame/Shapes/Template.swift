//
//  Template.swift
//  TetrisGame
//
//  Created by Lily Ewing on 3/24/22.
//

import SpriteKit

class Template : SKNode {
    
    var size: (x: Int, y: Int) {
        shape.size
    }
    
    let shape: Shape
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structure: [GridPoint]) {
        
        shape = Shape(structure: structure, blockImage: "templateBlock")
        super.init()
        shape.replaceBlocks(in: self)
    }
    
    
}
   
