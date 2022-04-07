//
//  Shape.swift
//  TetrisGame
//
//  Created by Lily Ewing on 3/29/22.
//

import SpriteKit

/// Size of the central square in each block image, and basis of the block grid.
let blockSize = 40

/// Size of the sprite image for each block.
let blockImageSize = 90


/**
 Creates blocks of specified colors & assembles based on given structure
 */
class Shape : SKNode {
    
    let size: (x: Int, y: Int)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structurePos : [(x: Int, y: Int)], image: String) {
        size = (
            structurePos.map(\.x).max() ?? 0,
            structurePos.map(\.y).max() ?? 0
        )

        super.init()
        
        for (x, y) in structurePos {
            let block = createBlock(x:x,y:y, imageName: image)
            addChild(block)
        }
    }
    
    func createBlock(x: Int, y: Int, imageName: String) -> SKSpriteNode{
        let singleBlock = SKSpriteNode(imageNamed: imageName)
        singleBlock.size = CGSize(width: blockImageSize, height: blockImageSize)
        singleBlock.position = CGPoint(
            x: blockSize * x + blockSize / 2,
            y: blockSize * y + blockSize / 2)
        return singleBlock
    }

}
