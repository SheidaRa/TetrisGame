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
let blockImageSize = 40


/**
 Creates blocks of specified colors & assembles based on given structure
 */
class Shape : SKNode {
    
    let image: String
    
    var layout: [(x: Int, y: Int)] = [] {
        didSet {
            removeAllChildren()
            for (x, y) in layout {
                let block = createBlock(x:x,y:y, imageName: image)
                addChild(block)
            }
        }
    }
    
    var size: (x: Int, y: Int) {
        (
            layout.map(\.x).max() ?? 0,
            layout.map(\.y).max() ?? 0
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(layout: [(x: Int, y: Int)], image: String) {
        self.image = image
        super.init()
        defer {  // didSet will not run until after init is finished
            self.layout = layout
        }
    }
    
    func createBlock(x: Int, y: Int, imageName: String) -> SKSpriteNode {
        let singleBlock = SKSpriteNode(imageNamed: imageName)
        singleBlock.size = CGSize(width: blockImageSize, height: blockImageSize)
        singleBlock.position = CGPoint(
            x: blockSize * x + blockSize / 2,
            y: blockSize * y + blockSize / 2)
        return singleBlock
    }
    
    func rotate() {
        let newLayout = layout.map { (x,y) in (x: y, y: -x) }
        let minX = newLayout.map(\.x).min() ?? 0
        let minY = newLayout.map(\.y).min() ?? 0
        self.layout = newLayout.map{ (x,y) in (x - minX, y - minY) }
    }
}
