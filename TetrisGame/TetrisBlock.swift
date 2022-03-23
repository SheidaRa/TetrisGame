//
//  TetrisBlock.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/22/22.
//

import SpriteKit

let blockSize = 40
public let block = SKNode()

class TetrisBlock : SKNode{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: CGSize) {
        super.init()
        block.position = CGPoint(x: size.width, y: size.height)
        
        var tetrisType = (
            (0,0),
            (0,1),
            (1,0),
            (1,1)
        )
        
        
        let singleblock = SKShapeNode(rect: CGRect(x: size.width/2, y: size.width/2, width: 40, height: 40))
        singleblock.fillColor = SKColor.white
        singleblock.lineWidth = CGFloat(5.0)
        singleblock.strokeColor = SKColor.red
        
        block.addChild(singleblock)
    }
    
    
    
    
    
    
}
