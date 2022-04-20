//
//  CoordConversion.swift
//  TetrisGame
//
//  Created by Lily Ewing on 4/18/22.
//

import SpriteKit

class CoordConversion {
    
    let xOffset: Int
    let yOffset: Int
    
    init(xOffset: Int, yOffset: Int) {
        self.xOffset = xOffset
        self.yOffset = yOffset
    }
    
    func snapToGrid(coord: CGPoint) -> CGPoint{
        let point = sceneToGrid(coord: coord)
        return gridToScene(gridPoint: point)
    }
    
    //converts from CGPoint to grid point
    func sceneToGrid(coord: CGPoint) -> (Int, Int){
        let x = (Double(coord.x) - Double(xOffset)) / Double(blockSize)
        let y = (Double(coord.y) - Double(yOffset)) / Double(blockSize)
        
        return (Int(x.rounded()), Int(y.rounded()))
    }
    
    //converts from (Int, Int) to CGPoint
    func gridToScene(gridPoint:(x:Int, y:Int)) -> CGPoint{
        return CGPoint(
            x: (gridPoint.x * blockSize) + xOffset,
            y: (gridPoint.y * blockSize) + yOffset)
    }
}
