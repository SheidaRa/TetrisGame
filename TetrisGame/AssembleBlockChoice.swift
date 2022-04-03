//
//  AssembleBlockChoice.swift
//  TetrisGame
//
//  Created by Lily Ewing on 3/29/22.
//

import SpriteKit

/**
 Creates blocks of specified colors & assembles based on given structure
 */

let blockSize = 90
let pieceLineW = 3
let templateLineW = 6

class AssembleBlockChoice : SKNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structurePos : [(Int, Int)], image: String) {
        super.init()
        
        for (x, y) in structurePos {
            let block = createBlock(x:x,y:y, imageName: image)
            addChild(block)
        }
    }
    
    func createBlock(x: Int, y: Int, imageName: String) -> SKSpriteNode{
        let singleBlock = SKSpriteNode(imageNamed: imageName)
        singleBlock.size = CGSize(width: blockSize, height: blockSize)
        singleBlock.position = CGPoint(x: 40 * x, y: 40 * y)
        return singleBlock
    }
    
    func blockSettings(block: SKShapeNode, fillColor: SKColor, lineColor: SKColor, lineWidth: Int){
        block.fillColor = fillColor
        block.lineWidth = CGFloat(lineWidth)
        block.strokeColor = lineColor
    }
}
