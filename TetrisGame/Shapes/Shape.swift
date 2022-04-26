//
//  Shape.swift
//  TetrisGame
//
//  Created by Lily Ewing on 3/29/22.
//

import SpriteKit

/// Size of the central square in each block image, and basis of the block grid.
let blockSize = 35 //40

/// Size of the sprite image for each block.
let blockImageSize = 36 //41

/**
 Creates blocks of specified colors & assembles based on given structure
 */
class Shape : SKNode {
    
    let image: String
    
    var layout: [GridPoint] = [] {
        didSet {
            removeAllChildren()
            for point in layout {
                let block = createBlock(position: point, imageName: image)
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
    
    init(layout: [GridPoint], image: String) {
        self.image = image
        super.init()
        defer {  // didSet will not run until after init is finished
            self.layout = layout
        }
    }
    
    func createBlock(position: GridPoint, imageName: String) -> SKSpriteNode {
        let singleBlock = SKSpriteNode(imageNamed: imageName)
        singleBlock.size = CGSize(width: blockImageSize, height: blockImageSize)
        singleBlock.position = CGPoint(
            x: blockSize * position.x + blockSize / 2,
            y: blockSize * position.y + blockSize / 2)
        return singleBlock
    }
    
    func rotate() {
        let newLayout = layout.map { point in GridPoint(x: point.y, y: -point.x) }
        let minX = newLayout.map(\.x).min() ?? 0
        let minY = newLayout.map(\.y).min() ?? 0
        self.layout = newLayout.map{ point in GridPoint(x: point.x - minX, y: point.y - minY) }
    }
    
    func flip(){
        let newLayout = layout.map { point in GridPoint(x: -point.x, y: point.y) }
        let minX = newLayout.map(\.x).min() ?? 0
        self.layout = newLayout.map{ point in GridPoint(x: point.x - minX, y: point.y ) }
        
    }
}
