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
    
    let gridWidth: Int

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // constructor for GameScene
    override init(size: CGSize) {
        template = Template(structure: t3)
        gridWidth = Int((Double(size.width)/40).rounded())
      
        let centeredX = Int(size.width)/2 - (((template.size.x+1) * blockSize)/2)
        let centeredY = Int(size.height)*3/5 - ((template.size.y * blockSize)/2)
        
        gridXOffset = centeredX % blockSize
        gridYOffset = centeredY % blockSize

        super.init(size: size)
        
        template.position = CGPoint(x: centeredX, y: centeredY)
        template.zPosition = 0
        self.addChild(template)

        let piece1 = Piece(structure: stairShape, blockColor: "B1")
        //piece1.constraints = [SKConstraint.positionX(xRange), SKConstraint.positionY(yRange)]
        piece1.position = CGPoint(x: 80, y: 150)
        piece1.zPosition = 1
        addChild(piece1)
        
        let piece2 = Piece(structure: tShape, blockColor: "B2")
        piece2.position = CGPoint(x: 0, y: 150)
        piece2.zPosition = 1
        self.addChild(piece2)

        let piece3 = Piece(structure: squareShape, blockColor: "B3")
        piece3.position = CGPoint(x: 50, y: 50)
        piece3.zPosition = 1
        self.addChild(piece3)

        let piece4 = Piece(structure: pShape, blockColor: "B4")
        piece4.position = CGPoint(x: 25, y: 300)
        piece4.zPosition = 1
        self.addChild(piece4)

        let piece5 = Piece(structure: uShape, blockColor: "B5")
        piece5.position = CGPoint(x: 180, y: 20)
        piece5.zPosition = 1
        self.addChild(piece5)
        
        let piece6 = Piece(structure: stairShape, blockColor: "B6")
        piece6.position = CGPoint(x: 60, y: 30)
        piece6.zPosition = 1
        self.addChild(piece6)
        
        let piece7 = Piece(structure: bomrangLShape, blockColor: "B7")
        piece7.position = CGPoint(x: 60, y: 30)
        piece7.zPosition = 1
        self.addChild(piece7)
        
        let piece8 = Piece(structure: longLShape, blockColor: "B8")
        piece8.position = CGPoint(x: 60, y: 30)
        piece8.zPosition = 1
        self.addChild(piece8)
        
        let piece9 = Piece(structure: idkShape, blockColor: "B9")
        piece9.position = CGPoint(x: 60, y: 30)
        piece9.zPosition = 1
        self.addChild(piece9)
        
        let piece10 = Piece(structure: trailShape, blockColor: "B10")
        piece10.position = CGPoint(x: 60, y: 30)
        piece10.zPosition = 1
        self.addChild(piece10)
        
        let piece11 = Piece(structure: plusShape, blockColor: "B11")
        piece11.position = CGPoint(x: 60, y: 30)
        piece11.zPosition = 1
        self.addChild(piece11)
        
        let piece12 = Piece(structure: longzShape, blockColor: "B12")
        piece12.position = CGPoint(x: 60, y: 30)
        piece12.zPosition = 1
        self.addChild(piece12)
        
        let piece13 = Piece(structure: longStairShape, blockColor: "B13")
        piece13.position = CGPoint(x: 60, y: 30)
        piece13.zPosition = 1
        self.addChild(piece13)
        
        let piece14 = Piece(structure: idk2Shape, blockColor: "B14")
        piece14.position = CGPoint(x: 60, y: 30)
        piece14.zPosition = 1
        self.addChild(piece14)
        
        let piece15 = Piece(structure: trailJumpShape, blockColor: "B15")
        piece15.position = CGPoint(x: 60, y: 30)
        piece15.zPosition = 1
        self.addChild(piece15)
        
        
        
        
        
        
        
        
        
        
        
        
        
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
                touchedBlock.position += curTouchPos - prevTouchPos
                
                if touchedBlock.position.x < 0 {
                    touchedBlock.position = CGPoint(x: 0, y: touchedBlock.position.y)
                }
                if touchedBlock.maxX(piece: touchedBlock, coord: touchedBlock.position) > frame.maxX {
                    let x = frame.maxX - (CGFloat((touchedBlock.size.x+1) * blockSize))
                    touchedBlock.position = CGPoint(x: x, y: touchedBlock.position.y)
                }
                if touchedBlock.maxY(piece: touchedBlock, coord: touchedBlock.position) > frame.maxY{
                    let y = frame.maxY - (CGFloat((touchedBlock.size.y+1) * blockSize))
                    touchedBlock.position = CGPoint(x: touchedBlock.position.x, y: y)
                }
                if touchedBlock.position.y < 0 {
                    touchedBlock.position = CGPoint(x: touchedBlock.position.x, y: 1)
                }
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let prevTouchPos = touch.previousLocation(in: self)

            if let touchedBlock = piece(at: prevTouchPos) {
                //print(template) //see if piece and template overlap, use CGRect in template to see if bounding rectangles overlap one another, then snap to grid
                touchedBlock.position = snapToGrid(coord: touchedBlock.position)
                // It always snaps no matter what  (we should need a condition it to be a template piece)
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
        let y = (Double(coord.y) - Double(gridYOffset)) / Double(blockSize)
        
        return (Int(x.rounded()), Int(y.rounded()))
    }
    
    //converts from (Int, Int) to CGPoint
    func gridToScene(gridPoint:(x:Int, y:Int)) -> CGPoint{
        return CGPoint(
            x: (gridPoint.x * blockSize) + gridXOffset,
            y: (gridPoint.y * blockSize) + gridYOffset)
    }
}
