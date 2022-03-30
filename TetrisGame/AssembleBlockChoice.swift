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

let blockSize: Double = 40
let pieceLineW = 3
let templateLineW = 6

class AssembleBlockChoice : SKNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(structurePos : [(Int, Int)], fillColor: SKColor, lineColor: SKColor, lineWidth: Int) {
        super.init()
        
        for (x, y) in structurePos { 
            let block = createBlock(x:x,y:y, fillColor: fillColor, lineColor: lineColor, lineWidth: lineWidth)
            addChild(block)
        }
    }
    
    func createBlock(x: Int, y: Int, fillColor: SKColor, lineColor: SKColor, lineWidth: Int) -> SKShapeNode{
        let singleBlock = SKShapeNode(rect: CGRect(x: blockSize * Double(x) , y: blockSize * Double(y) , width: blockSize, height: blockSize))
        blockSettings(block: singleBlock, fillColor: fillColor, lineColor: lineColor, lineWidth: lineWidth)
        return singleBlock
    }
    
    func blockSettings(block: SKShapeNode, fillColor: SKColor, lineColor: SKColor, lineWidth: Int){
        block.fillColor = fillColor
        block.lineWidth = CGFloat(lineWidth)
        block.strokeColor = lineColor
    }
}
