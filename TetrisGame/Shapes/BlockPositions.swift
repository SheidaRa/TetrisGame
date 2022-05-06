//
//  BlockPositions.swift
//  TetrisGame
//
//  Created by Lily Ewing on 5/5/22.
//

import SpriteKit

/**
 Calculates and keeps track of the positions of individual blocks
 */
class BlockPositions{
    
    let template: Template
    
    init(template: Template){
        self.template = template
    }
    
    /**
     Takes a list of all pieces onscreen and returns the position of every block
     **/
    func piecesBlocks(pieces: [Piece]) -> [GridPoint] {
        var coordList: [GridPoint] = []
        for piece in pieces{
            let coord = piece.shape.layout
            var allX = coord.map(\.x)
            var allY = coord.map(\.y)
            for _ in 1...allX.count{
                let newX = Int(piece.position.x) + (Int(allX.removeFirst()) * blockSize) + blockSize
                let newY = Int(piece.position.y) + (Int(allY.removeFirst()) * blockSize) + blockSize
                coordList.append(GridPoint(x: newX, y: newY))
            }
        }
        return coordList
    }
    
    /**
     returns the position of every block in the template
     */
    func templateBlockPos() -> [GridPoint]{
        var coordList: [GridPoint] = []
        let coord = template.shape.layout
        for block in coord{
            let newX = Int(template.position.x) + (block.x * blockSize) + blockSize
            let newY = Int(template.position.y) + (block.y * blockSize) + blockSize
            coordList.append(GridPoint(x: newX, y: newY))
        }
        return coordList
        
    }

    /**
     Create a dictionary with the template's blocks' position as the key and 0 as the value for each
     */
    func createTemplateDic() -> [GridPoint:Int] {
        var coordMap: [GridPoint:Int] = [:]
        let coordList = templateBlockPos()
        for point in coordList{
            coordMap[point] = 0
        }
        return coordMap
    }
    
    /**
     Creates a dictionary with all pieces' block positions as the keys and the value the number of blocks in that position
     */
    func createPieceDic(piecesList: [Piece]) -> [GridPoint: Int]{
        var coordMap: [GridPoint:Int] = [:]
        let coordList = piecesBlocks(pieces: piecesList)
        for point in coordList{
            if let val = coordMap[point]{
                coordMap[point] = val + 1
            } else{
                coordMap[point] = 1
            }
        }
        return coordMap
    }
    
    /**
     Creates a dictionary with the template blocks' coordinates as keys. The values are the number of piece blocks in the same position.
     */
    func fillDictionary(piecesList: [Piece]) -> [GridPoint: Int] {
        let piecesBlockPos = piecesBlocks(pieces: piecesList)
        var templateMap = createTemplateDic()
        
        for point in piecesBlockPos{
            for coord in templateMap.keys{
                if(point == coord){
                    templateMap.updateValue(1 + Int(templateMap[coord] ?? 0), forKey: coord)
                }
            }
        }
        return templateMap
    }
    
    /**
     Checks the positions of all pieces onscreen, if more than one are in the same position returns true
     */
    func overlap(pieces: [Piece]) -> Bool {
        var overlapping: Bool = false
        let pieceDic = createPieceDic(piecesList: pieces)
        for coord in pieceDic.keys{
            if pieceDic[coord] != 1{
                overlapping = true
            }
        }
        return overlapping
    }
}
