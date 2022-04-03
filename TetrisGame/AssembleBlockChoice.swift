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
    
    //fillColor: SKColor, lineColor: SKColor, lineWidth: Int
    init(structurePos : [(Int, Int)]) {
        super.init()
        
        for (x, y) in structurePos {
            // fillColor: fillColor, lineColor: lineColor, lineWidth: lineWidth
            let block = createBlock(x:x,y:y)
            addChild(block)
        }
    }
    
    //, fillColor: SKColor, lineColor: SKColor, lineWidth: Int
    func createBlock(x: Int, y: Int) -> SKSpriteNode{
        let singleBlock = SKSpriteNode(imageNamed: "block1")
        singleBlock.size = CGSize(width: blockSize, height: blockSize)
        singleBlock.position = CGPoint(x: 40 * x, y: 40 * y)
//        let singleBlock = SKShapeNode(rect: CGRect(x: blockSize * Double(x) , y: blockSize * Double(y) , width: blockSize, height: blockSize))
//        blockSettings(block: singleBlock, fillColor: fillColor, lineColor: lineColor, lineWidth: lineWidth)
        return singleBlock
    }
    
    func blockSettings(block: SKShapeNode, fillColor: SKColor, lineColor: SKColor, lineWidth: Int){
        block.fillColor = fillColor
        block.lineWidth = CGFloat(lineWidth)
        block.strokeColor = lineColor
    }
}
