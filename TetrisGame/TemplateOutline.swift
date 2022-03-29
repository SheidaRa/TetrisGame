//
//  TemplateOutline.swift
//  TetrisGame
//
//  Created by Lily Ewing on 3/24/22.
//

import SpriteKit

//let templateUnit = SKNode()

class TemplateOutline : SKNode{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: CGSize) { //init like initializer?
        super.init()
        //templateUnit.position = CGPoint(x: size.width, y: size.height)
        let coord = [(0,0), (0,1), (0,2), (1,0), (1,1), (1,2), (1,3)]
        
        for (x, y) in coord { //for loop that creates multiple blocks, & sets their position
            let block = createBlock(size: size)
            positionBlock(coord: (x,y), block: block)
            addChild(block)
        }
    }
    
    
    func createBlock(size: CGSize) -> SKShapeNode{
        let singleBlock = SKShapeNode(rect: CGRect(x: size.width/2, y: size.width/2, width: 40, height: 40)) //x & y terms set the origin of rec? that's what gets moved? what is CGSize
        
        blockSettings(block: singleBlock)
        return singleBlock
    }
    
    func blockSettings(block: SKShapeNode){
        block.fillColor = SKColor.lightGray
        block.lineWidth = CGFloat(5.0)
        block.strokeColor = SKColor.white
    }
    
    func positionBlock(coord: (Int, Int), block: SKShapeNode){
        let xPos = coord.0
        let yPos = coord.1
        block.position = CGPoint(x: xPos, y: yPos)
    }
}
