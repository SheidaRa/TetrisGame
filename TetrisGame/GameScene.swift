//
//  GameScene.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/16/22.
//

import SpriteKit

class GameScene: SKScene {
    
    let template: Template
    
    let offset: Int

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(size: CGSize) {
        template = Template(structure: t2)
        
//        let xRange = SKRange(lowerLimit: 0, upperLimit: size.width)
//        let yRange = SKRange(lowerLimit: 0, upperLimit: size.height)
        
        let centeredX = Int((size.width))/2 - (((template.size.x+1) * blockSize)/2)
        
        offset = centeredX % blockSize

        super.init(size: size)
        
        let centeredY = Int(size.height)*3/5 - ((template.size.y * blockSize)/2)
        let center = CGPoint(x: centeredX, y: centeredY)
        template.position = center
        template.zPosition = 0
        self.addChild(template)

        let piece1 = Piece(structure: stairShape, blockColor: "redBlock")
        //piece1.constraints = [SKConstraint.positionX(xRange), SKConstraint.positionY(yRange)]
        piece1.position = CGPoint(x: 80, y: 150)
        piece1.zPosition = 1
        addChild(piece1)
        
        let piece2 = Piece(structure: tShape, blockColor: "blueBlock")
        //piece2.constraints = [SKConstraint.positionX(xRange), SKConstraint.positionY(yRange)]
        piece2.position = CGPoint(x: 0, y: 150)
        piece2.zPosition = 1
        self.addChild(piece2)

        let piece3 = Piece(structure: squareShape, blockColor: "yellowBlock")
        //piece3.constraints = [SKConstraint.positionX(xRange), SKConstraint.positionY(yRange)]
        piece3.position = CGPoint(x: 50, y: 50)
        piece3.zPosition = 1
        self.addChild(piece3)

        let piece4 = Piece(structure: pShape, blockColor: "purpleBlock")
        //piece4.constraints = [SKConstraint.positionX(xRange), SKConstraint.positionY(yRange)]
        piece4.position = CGPoint(x: 25, y: 300)
        piece4.zPosition = 1
        self.addChild(piece4)

        let piece5 = Piece(structure: uShape, blockColor: "greenBlock")
        //piece5.constraints = [SKConstraint.positionX(xRange), SKConstraint.positionY(yRange)]
        piece5.position = CGPoint(x: 180, y: 20)
        piece5.zPosition = 1
        self.addChild(piece5)
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let curTouchPos = touch.location(in: self)
            let prevTouchPos = touch.previousLocation(in: self)

            let touchedNode = atPoint(prevTouchPos)
            if let touchedBlock = touchedNode.parent?.parent as? Piece {
                touchedBlock.zPosition = (touchedBlock.parent?.children.map(\.zPosition).max() ?? 0) + 1
                let changedPosition = touchedBlock.position + (curTouchPos - prevTouchPos)
                
                // if the piece's position change is in the screen, frame, then allow the position to change, otherwise, don't change the position
                if (changedPosition.x >= frame.minX
                    && changedPosition.x <= frame.maxX
                    && changedPosition.y >= frame.minY
                    && changedPosition.y <= frame.maxY)
                {
                    touchedBlock.position += curTouchPos - prevTouchPos
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let prevTouchPos = touch.previousLocation(in: self)
            let touchedNode = atPoint(prevTouchPos)

            if let touchedBlock = touchedNode.parent?.parent as? Piece {
                print(template) //see if piece and template overlap, use CGRect in template to see if bounding rectangles overlap one another, then snap to grid
                touchedBlock.position = snapToGrid(coord: touchedBlock.position)
            }
        }
    }
    
    func snapToGrid(coord: CGPoint) -> CGPoint{
        let point = sceneToGrid(coord: coord)
        return gridToScene(gridPoint: point)
    }
    
    //converts from CGPoint to grid point
    func sceneToGrid(coord: CGPoint) -> (Int, Int){
        var x = Double(coord.x) - Double(offset)
        x = x / Double(blockSize)
        let roundedX = Int(x.rounded())
        
        var y = Double(coord.y)
        y = y / Double(blockSize)
        let roundedY = Int(y.rounded())
        
        return (roundedX, roundedY)
    }
    
    //converts from (Int, Int) to CGPoint
    func gridToScene(gridPoint:(x:Int, y:Int)) -> CGPoint{
        let coord = CGPoint(
            x: (gridPoint.x * blockSize) + offset,
            y: (gridPoint.y * blockSize) )
        print("coord x: ", coord.x)
        return coord
    }
    
    func tapRotate(_ gestureRecognizer: UITapGestureRecognizer){ //on tap, will just store position in varibale, delete from screen, generate new piece (shape rotated 90) in same position
        guard gestureRecognizer.view != nil else { return }
               
          if gestureRecognizer.state == .ended {
            
          }
    }
}
