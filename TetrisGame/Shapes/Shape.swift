//
//  Shape.swift
//  TetrisGame
//
//  Created by Lily Ewing on 3/29/22.
//

import SpriteKit

/// Size of the central square in each block image, and basis of the block grid.
let blockSize = 35

/// Size of the sprite image for each block.
let blockImageSize = 36

/**
 Creates blocks of specified colors & assembles based on given structure
 */
struct Shape {
    
    let image: String
    
    var layout: [GridPoint]
    
    var size: (x: Int, y: Int) {
        (
            layout.map(\.x).max() ?? 0,
            layout.map(\.y).max() ?? 0
        )
    }
    
    init(structure: [GridPoint], blockImage: String) {
        self.image = blockImage
        self.layout = structure
    }
    
    func replaceBlocks(in parent: SKNode) {
        parent.removeAllChildren()
        for point in layout {
            let block = createBlock(position: point, imageName: image)
            parent.addChild(block)
        }
    }
    
    private func createBlock(position: GridPoint, imageName: String) -> SKSpriteNode {
        let singleBlock = SKSpriteNode(imageNamed: imageName)
        singleBlock.size = CGSize(width: blockImageSize, height: blockImageSize)
        singleBlock.position = CGPoint(
            x: blockSize * position.x + blockSize / 2,
            y: blockSize * position.y + blockSize / 2)
        return singleBlock
    }
    
    mutating func rotate() {
        let newLayout = layout.map { point in GridPoint(x: point.y, y: -point.x) }
        let minX = newLayout.map(\.x).min() ?? 0
        let minY = newLayout.map(\.y).min() ?? 0
        self.layout = newLayout.map { point in GridPoint(x: point.x - minX, y: point.y - minY) }
    }
    
    mutating func flip() {
        let newLayout = layout.map { point in GridPoint(x: -point.x, y: point.y) }
        let minX = newLayout.map(\.x).min() ?? 0
        self.layout = newLayout.map { point in GridPoint(x: point.x - minX, y: point.y ) }
    }
    
    func flipped() -> Shape {
        var newShape = self
        newShape.flip()
        return newShape
    }
}
