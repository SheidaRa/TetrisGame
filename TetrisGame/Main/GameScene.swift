//
//  GameScene.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/16/22.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "TetrisBackground")
    
    var playButton: SKSpriteNode?

    let winCupAnimation: SKAction
    
    var isFrozen: Bool
    
    let levelIndex: Int
    
    let template: Template
    
    let gridXOffset: Int
    let gridYOffset: Int

    var piecesList: [Piece]
    
    let coordCon: CoordConversion
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // constructor for GameScene
    init(size: CGSize, levelIndex: Int) {
        isFrozen = false
        //game = gameLevel
        self.levelIndex = levelIndex
        let game = allLevels[levelIndex]
//        game = lvl8 //2, 3, 4
        template = game.template
        
        
        print("helo world")
        
        
        let centeredX = Int(size.width)/2 - (((template.size.x+1) * blockSize)/2)
        let centeredY = Int(size.height)*2/3 - ((template.size.y * blockSize)/2)
        gridXOffset = centeredX % blockSize
        gridYOffset = centeredY % blockSize
        
        coordCon = CoordConversion(xOffset: gridXOffset, yOffset: gridYOffset)
        
        piecesList = []
        
        var textures: [SKTexture] = []
        for i in 0...9 {
            textures.append(SKTexture(imageNamed: "win\(i)"))
        }
        winCupAnimation = SKAction.repeatForever(
            SKAction.animate(withNormalTextures: textures, timePerFrame: 0.1))
        super.init(size: size)


        
        self.backgroundColor = SKColor.black
        self.background.name = "background"
        self.background.size = CGSize(width: 775, height: 1007)
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
        
        template.position = CGPoint(x: centeredX, y: centeredY)
        template.zPosition = ZPositions.template.rawValue
        self.addChild(template)
        
        piecesList = game.shapes.map(Piece.init)
        var count = 0
        var verticalCount = 0
        for piece in piecesList {
            piece.position = CGPoint(x: Int(size.width/3) * count + 20, y: Int(template.position.y) - Int(piece.size.y*blockSize)  - 8 - Int(size.height)/5 * verticalCount)
            piece.zPosition = ZPositions.piece.rawValue
            self.addChild(piece)
            piece.run(SKAction.moveBy(x: 0, y: -30, duration: 0.5))
            
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
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            if atPoint(convertPoint(fromView: tap.location(in: self.view))) == playButton {
                let nextScene: SKScene
                if levelIndex+1 < allLevels.count {
                    nextScene = GameScene(size: self.size, levelIndex: levelIndex + 1)
                } else {
                    nextScene = HomeScene(size: self.size)
                }
                nextScene.scaleMode = .aspectFit
                self.view?.presentScene(nextScene, transition: SKTransition.moveIn(with: SKTransitionDirection.down, duration: 0.5))
            }

        }
    }
    
    // creates a function to handle tap gesture to rotate the piece
    @objc func handleDoubleTap(_ tap: UITapGestureRecognizer) {
        guard !isFrozen else {
            return
        }
        if tap.state == .ended {
            //print("    looking for piece")
            if let touchedPiece = piece(at: convertPoint(fromView: tap.location(in: self.view))) {
                //print("    found piece")
                touchedPiece.zPosition = (touchedPiece.parent?.children.map(\.zPosition).max() ?? 0) + 1
                touchedPiece.shape.rotate()
                
                touchedPiece.position = coordCon.snapToGrid(coord: touchedPiece.position)
                isFrozen = hasWon()
                
               handleOverlap(piece: touchedPiece)
            }
        }
    }
    
    // function to check if the piece tapped or moved is a tetris piece or not
    func piece(at pos: CGPoint) -> Piece? {
        let node = atPoint(pos)
        //print("    ---> found node", node)
        return node.parent as? Piece
    }
    
    // function to handle tetris piece movement
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            let curTouchPos = touch.location(in: self)
            let prevTouchPos = touch.previousLocation(in: self)
            
            guard !isFrozen else {
                return
            }

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
        super.touchesEnded(touches, with: event)
        touchesFinished(touches: touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchesFinished(touches: touches)
    }
    
    func touchesFinished(touches: Set<UITouch>){
        guard !isFrozen else {
            return
        }
        for touch in touches {
            let prevTouchPos = touch.previousLocation(in: self)
            if let touchedBlock = piece(at: prevTouchPos) {
                touchedBlock.position = coordCon.snapToGrid(coord: touchedBlock.position)
                isFrozen = hasWon()
                if hasWon() {
                    winAnimation()
                }
//                print("overlap exists ", overlap())
                handleOverlap(piece: touchedBlock)
            }
        }
        
    }
    

    func winAnimation () {
        addPlayNextLevelButton()
        
        for gridPoint in fillDictionary().keys {
            let winParticleTop = SKEmitterNode(fileNamed: "Spark.sks")!
            winParticleTop.zPosition = ZPositions.winParticles.rawValue
            // This should be coordCon.gridToScene(gridPoint: gridPoint), but
            // fillDictionary() is really returning CGPoints, not GridPoints
            winParticleTop.position = CGPoint(x: gridPoint.x - blockSize/2 , y: gridPoint.y - blockSize/2)
            addChild(winParticleTop)
            winParticleTop.run(SKAction.fadeIn(withDuration: 10))
        }

//        let winParticleBottom = SKEmitterNode(fileNamed: "Spark.sks")
//        winParticleBottom?.zPosition = 6
//        winParticleBottom?.position = CGPoint(x: 15, y: 15)
//        addChild(winParticleBottom!)
//        winParticleBottom?.run(SKAction.fadeIn(withDuration: 1))
//
//        let winParticleTop = SKEmitterNode(fileNamed: "Spark.sks")
//        winParticleTop?.zPosition = 6
//        winParticleTop?.position = CGPoint(x: 360, y: 660)
//        addChild(winParticleTop!)
//        winParticleTop?.run(SKAction.fadeIn(withDuration: 1))
    }
    
    func addPlayNextLevelButton () {
        let playHalo = SKSpriteNode(imageNamed: "playHalo")
        playHalo.size = CGSize (width: 200, height: 200)
        playHalo.position = CGPoint(x: 200, y: 160)
        playHalo.zPosition = ZPositions.controls.rawValue
        let playHaloaAnimation = SKAction.sequence([SKAction.rotate(byAngle: 10, duration: 10)])
        playHalo.run(SKAction.repeatForever(playHaloaAnimation))
        addChild(playHalo)
        
        let playButton = SKSpriteNode(imageNamed: "BackB")
        playButton.size = CGSize (width: 78, height: 78)
        playButton.position = CGPoint(x: 205, y: 160)
        playButton.zPosition = ZPositions.controls.rawValue
        let playButtonAnimation = SKAction.fadeIn(withDuration: 0.1)
        addChild(playButton)
        playButton.run(playButtonAnimation)
        
        self.playButton = playButton
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
    func fillDictionary() -> [GridPoint: Int] {
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
    
    enum ZPositions: CGFloat {
        case background
        case winParticles
        case template
        case piece
        // piece Z positions increase with every move, so we need a large gap for win nodes
        case winImage = 1e10
        case controls = 2e10
    }
}
