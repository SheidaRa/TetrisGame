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
        
        var ltetris = (
            (0,0),
            (0,1),
            (1,0),
            (1,1)
        )
        
       // for (x,y) in ltetris {
        let singleblock = SKShapeNode(rect: CGRect(x: Int(size.width)/2, y: Int(size.height)/2, width: blockSize, height: blockSize))
            singleblock.fillColor = SKColor.white
            singleblock.lineWidth = CGFloat(5.0)
            singleblock.strokeColor = SKColor.red
            
            block.addChild(singleblock)
       // }
        
        
    }
    
    
    
    
    
    
}
