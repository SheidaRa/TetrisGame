//
//  GameScene.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/16/22.
//

import SpriteKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "TetrisBackground")
    
    let template: Template
    
    let gridXOffset: Int
    let gridYOffset: Int

    var piecesList: [Piece]
    
    let coordCon: CoordConversion
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // constructor for GameScene
    override init(size: CGSize) {
        let game = GameLevel(size: size, level: 1)
        template = game.loadGameSet().template
        //gridWidth = Int((Double(size.width)/40).rounded())
        
        let centeredX = Int(size.width)/2 - (((template.size.x+1) * blockSize)/2)
        let centeredY = Int(size.height)*2/3 - ((template.size.y * blockSize)/2)
        gridXOffset = centeredX % blockSize
        gridYOffset = centeredY % blockSize
        
        coordCon = CoordConversion(xOffset: gridXOffset, yOffset: gridYOffset)
        
        piecesList = []

        super.init(size: size)
        
        self.backgroundColor = SKColor.black
        self.background.name = "background"
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
        
        template.position = CGPoint(x: centeredX, y: centeredY)
        template.zPosition = 1
        self.addChild(template)
        
        piecesList = game.loadGameSet().pieces
        var count = 0
        var verticalCount = 0
        for piece in game.loadGameSet().pieces {
            piece.position = CGPoint(x: 120 * count, y: 150 - 120 * verticalCount)
            piece.zPosition = 1
            self.addChild(piece)
            
            count += 1
            if count % 3 == 0 {
                verticalCount += 1
                count = 0
            }
        }
    }
    
    // override function to check if the tetris piece moves or not
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
    }
    
    // creates a function to handle 2x tap gesture to flip/mirror the piece
    @objc func handleDoubleTap(_ doubleTap: UITapGestureRecognizer){
        if doubleTap.state == .ended{
            if let touchedPiece = piece(at: convertPoint(fromView: doubleTap.location(in: self.view))) {
                touchedPiece.zPosition = (touchedPiece.parent?.children.map(\.zPosition).max() ?? 0) + 1
                touchedPiece.shape.flip()
                
                touchedPiece.position = coordCon.snapToGrid(coord: touchedPiece.position)
                print("won: ", hasWon())
                
                handleOverlap(piece: touchedPiece)
            }
        }
    }
    
    // creates a function to handle tap gesture to rotate the piece
    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            if let touchedPiece = piece(at: convertPoint(fromView: tap.location(in: self.view))) {
                touchedPiece.zPosition = (touchedPiece.parent?.children.map(\.zPosition).max() ?? 0) + 1
                touchedPiece.shape.rotate()
                
                touchedPiece.position = coordCon.snapToGrid(coord: touchedPiece.position)
                print("won: ", hasWon())
                
               handleOverlap(piece: touchedPiece)
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
                touchedBlock.position = coordCon.snapToGrid(coord: touchedBlock.position)

                print("won: ", hasWon())
                print("overlap exists ", overlap())
                handleOverlap(piece: touchedBlock)
            }
        }
    }
    
  
    //takes layout coords of all pieces onscreen & returns position of blocks onscreen
    func pieceCoords(pieces: [Piece]) -> [GridPoint] {
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

    //creates dictionary with template block positions
    func createTemplateDic() -> [GridPoint:Int] {
        var coordMap: [GridPoint:Int] = [:]
        let coordList = templateBlockPos()
        for point in coordList{
            coordMap[point] = 0
        }
        return coordMap
    }
    
    //creates dictionary w all pieces' block positions
    //check if 2, then know overlap
    func createPieceDic() -> [GridPoint: Int]{
        var coordMap: [GridPoint:Int] = [:]
        let coordList = pieceCoords(pieces: piecesList)
        for point in coordList{
            if let val = coordMap[point]{
                coordMap[point] = val + 1
            } else{
                coordMap[point] = 1
            }
        }
        return coordMap
    }
    
    //dictionary of the template's coordinates, values are num blocks in same pos, if any value is 0, know puzzle not complete
    func fillDictionary() -> [GridPoint: Int]{
        let piecesBlockPos = pieceCoords(pieces: piecesList)
        var templateMap = createTemplateDic()
        
        for point in piecesBlockPos{
            for coord in templateMap.keys{
                if(point == coord){
                    templateMap.updateValue(1 + Int(templateMap[coord] ?? 0), forKey: coord) //prob a better way to do this
                }
            }
        }
        return templateMap
    }
    
    func hasWon() -> Bool {
        var won: Bool = true
        
        let templateMap = fillDictionary()
        let tempCoords = templateMap.values
        
        for num in tempCoords{
            if(num != 1){
                won = false
            }
        }
        return won
    }
    
    func overlap() -> Bool { //instead make so takes piece as input and checks to see if already a piece in that pos?
        var overlapping: Bool = false
        let pieceDic = createPieceDic()
        for coord in pieceDic.keys{
            if pieceDic[coord] != 1{
                overlapping = true
            }
        }
        return overlapping
    }
    
    func handleOverlap(piece: Piece){
        if overlap() == true{
            piece.position = CGPoint(x: piece.position.x + 10, y: piece.position.y + 10)
        }
    }
}
