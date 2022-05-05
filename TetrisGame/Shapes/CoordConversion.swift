//
//  CoordConversion.swift
//  TetrisGame
//
//  Created by Lily Ewing on 4/18/22.
//

import SpriteKit

/**
 Converts CGPoints to gridPoints along the game's grid system
 */
class CoordConversion {
    
    let xOffset: Int
    let yOffset: Int
    
    init(xOffset: Int, yOffset: Int) {
        self.xOffset = xOffset
        self.yOffset = yOffset
    }
    
    /**
     Takes CGpoint and returns equivalent CGPoint on the game's grid system
     */
    func snapToGrid(coord: CGPoint) -> CGPoint{
        let point = sceneToGrid(coord: coord)
        return gridToScene(gridPoint: point)
    }
    
    /**
     Converts from CGPoint to gridPoint on game's grid system
     */
    func sceneToGrid(coord: CGPoint) -> GridPoint {
        let x = (Double(coord.x) - Double(xOffset)) / Double(blockSize)
        let y = (Double(coord.y) - Double(yOffset)) / Double(blockSize)
        
        return GridPoint(x: Int(x.rounded()), y: Int(y.rounded()))
    }
    
    /**
     Converts from a GridPoint to a CGPoint
     */
    func gridToScene(gridPoint: GridPoint) -> CGPoint{
        return CGPoint(
            x: (gridPoint.x * blockSize) + xOffset,
            y: (gridPoint.y * blockSize) + yOffset)
    }
}
