//
//  GameScene.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/16/22.
//

import SpriteKit

class GameScene: SKScene {
    
    let template: Template
    
    let gridXOffset: Int
    
    let gridYOffset: Int

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // constructor for GameScene
    override init(size: CGSize) {
        template = Template(structure: t2)
        
//        let xRange = SKRange(lowerLimit: 0, upperLimit: size.width)
//        let yRange = SKRange(lowerLimit: 0, upperLimit: size.height)
        
        let centeredX = Int((size.width))/2 - (((template.size.x+1) * blockSize)/2)
        let centeredY = Int(size.height)*3/5 - ((template.size.y * blockSize)/2)
        
        gridXOffset = centeredX % blockSize
        gridYOffset = centeredY % blockSize

        super.init(size: size)
        
        template.position = CGPoint(x: centeredX, y: centeredY)
        template.zPosition = 0
        self.addChild(template)

        let piece1 = Piece(structure: stairShape, blockColor: "redBlock")
        //piece1.constraints = [SKConstraint.positionX(xRange), SKConstraint.positionY(yRange)]
        piece1.position = CGPoint(x: 80, y: 150)
        piece1.zPosition = 1
        addChild(piece1)
        
        let piece2 = Piece(structure: tShape, blockColor: "blueBlock")
        piece2.position = CGPoint(x: 0, y: 150)
        piece2.zPosition = 1
        self.addChild(piece2)

        let piece3 = Piece(structure: squareShape, blockColor: "yellowBlock")
        piece3.position = CGPoint(x: 50, y: 50)
        piece3.zPosition = 1
        self.addChild(piece3)

        let piece4 = Piece(structure: pShape, blockColor: "purpleBlock")
        piece4.position = CGPoint(x: 25, y: 300)
        piece4.zPosition = 1
        self.addChild(piece4)

        let piece5 = Piece(structure: uShape, blockColor: "greenBlock")
        piece5.position = CGPoint(x: 180, y: 20)
        piece5.zPosition = 1
        self.addChild(piece5)
    }
    
    // override function to check if the tetris piece moves or not
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    // creates a function to handle tap gesture to rotate the piece
    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            if let touchedPiece = piece(at: convertPoint(fromView: tap.location(in: self.view))) {
                touchedPiece.shape.rotate()
                touchedPiece.position = snapToGrid(coord: touchedPiece.position)
            }
        }
    }
    
    // function to check if the piece tapped or moved is a tetris piece or not
    func piece(at pos: CGPoint) -> Piece? {
        let node = atPoint(pos)
        return node.parent?.parent as? Piece
    }

    // function to handle tetris piece movement
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let curTouchPos = touch.location(in: self)
            let prevTouchPos = touch.previousLocation(in: self)

            if let touchedBlock = piece(at: prevTouchPos) {
                touchedBlock.zPosition = (touchedBlock.parent?.children.map(\.zPosition).max() ?? 0) + 1
                let changedPosition = touchedBlock.position + (curTouchPos - prevTouchPos)
                
                // if the piece's position change is in the screen, frame, then allow the position to change, otherwise, don't change the position
                if (changedPosition.x >= frame.minX
                    //&& changedPosition.x + CGFloat((touchedBlock.size.x+1) * blockSize) < frame.maxX
                    && changedPosition.y >= frame.minY
                    && changedPosition.y + CGFloat((touchedBlock.size.y+1) * blockSize) < frame.maxY)
                {
                    touchedBlock.position += curTouchPos - prevTouchPos
                }
            }
        }
    }
    
    // function that handles tetris piece situation when the touch movements end
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let prevTouchPos = touch.previousLocation(in: self)

            if let touchedBlock = piece(at: prevTouchPos) {
                //print(template) //see if piece and template overlap, use CGRect in template to see if bounding rectangles overlap one another, then snap to grid
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
        let x = (Double(coord.x) - Double(gridXOffset)) / Double(blockSize)
        let roundedX = Int(x.rounded())
        
        let y = (Double(coord.y) - Double(gridYOffset)) / Double(blockSize)
        let roundedY = Int(y.rounded())
        
        return (roundedX, roundedY)
    }
    
    //converts from (Int, Int) to CGPoint
    func gridToScene(gridPoint:(x:Int, y:Int)) -> CGPoint{
        return CGPoint(
            x: (gridPoint.x * blockSize) + gridXOffset,
            y: (gridPoint.y * blockSize) + gridYOffset)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}




