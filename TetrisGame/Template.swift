//
//  Template.swift
//  TetrisGame
//
//  Created by Lily Ewing on 3/24/22.
//

import SpriteKit

let t2 = [(1,0), (2,0),(3,0),
             (1,1), (2,1), (3,1), (4,1),
             (0,2),(1,2), (2,2), (3,2), (4,2),
             (0,3),(1,3), (2,3), (3,3), (4,3), (5,3),
             (0,4),(1,4), (2,4), (3,4), (4,4),
             (0,5),(1,5), (2,5), (3,5), (4,5),
             (3,6)]

let t3 = [(1,0), (2,0), (3,0), (4,0), (5,0),
          (1,1), (2,1), (3,1), (4,1), (5,1),
          (1,2), (2,2), (3,2), (5,2),
          (1,3), (2,3), (3,3), (4,3), (5,3),
          (0,4),(1,4), (2,4), (3,4), (4,4)]


class Template : SKNode {
    
    let size: (x: Int, y: Int)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structure: [(x: Int, y: Int)]) {
        size = (
            structure.map(\.x).max() ?? 0, //need to add one?
            structure.map(\.y).max() ?? 0
        )
        super.init()

        let template = Shape(structurePos: structure, image: "templateBlock")
        addChild(template)
        
        //let size = template.size
    }
    
    
}
   
