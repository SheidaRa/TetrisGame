//
//  TetrisBlock.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/22/22.
//

import SpriteKit

let blockSize: Double = 40

class TetrisBlock : SKNode{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        let ltetris = [
            (0,0),
            (0,1),
            (1,0),
            (1,1)
        ]
        
        for (x,y) in ltetris {
            let singleblock = SKShapeNode(
                    rect: CGRect(
                        x: blockSize * Double(x),
                        y: blockSize * Double(y),
                        width: blockSize,
                        height: blockSize))
            
            singleblock.fillColor = SKColor.white
            singleblock.lineWidth = CGFloat(5.0)
            singleblock.strokeColor = SKColor.red
            
            addChild(singleblock)
        }
    }
}
