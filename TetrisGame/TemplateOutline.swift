//
//  TemplateOutline.swift
//  TetrisGame
//
//  Created by Lily Ewing on 3/24/22.
//

import SpriteKit

class TemplateOutline : SKNode{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        let coord = [(1,0), (2,0),(3,0),
                     (1,1), (2,1), (3,1), (4,1),
                     (0,2),(1,2), (2,2), (3,2), (4,2),
                     (0,3),(1,3), (2,3), (3,3), (4,3), (5,3),
                     (0,4),(1,4), (2,4), (3,4), (4,4),
                     (0,5),(1,5), (2,5), (3,5), (4,5),
                     (3,6)]
        
        let template = AssemnbleBlockChoice(structurePos: coord, fillColor: SKColor.lightGray, lineColor: SKColor.white, lineWidth: templateLineW)
        addChild(template)
    }
}
   
