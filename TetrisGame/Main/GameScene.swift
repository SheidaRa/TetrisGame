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
    
    let blockPositions: BlockPositions
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: CGSize, levelIndex: Int) {
        isFrozen = false
        self.levelIndex = levelIndex
        let game = allLevels[levelIndex]
        template = game.template
        
        let centeredX = Int(size.width)/2 - (((template.size.x+1) * blockSize)/2)
        let centeredY = Int(size.height)*2/3 - ((template.size.y * blockSize)/2)
        gridXOffset = centeredX % blockSize
        gridYOffset = centeredY % blockSize
        
        coordCon = CoordConversion(xOffset: gridXOffset, yOffset: gridYOffset)
        blockPositions = BlockPositions(template: self.template)
        piecesList = []
        
        var textures: [SKTexture] = []
        for i in 0...9 {
            textures.append(SKTexture(imageNamed: "win\(i)"))
        }
        winCupAnimation = SKAction.repeatForever(
            SKAction.animate(withNormalTextures: textures, timePerFrame: 0.1))
        
        super.init(size: size)

        setBackground()
        addTemplate(x: centeredX, y: centeredY)
        
        piecesList = game.shapes.map(Piece.init)
        placePieces(pieces: piecesList)
    }
    
    func addTemplate(x: Int, y: Int){
        template.position = CGPoint(x: x, y: y)
        template.zPosition = ZPositions.template.rawValue
        self.addChild(template)
    }
    
    func setBackground(){
        self.backgroundColor = SKColor.black
        self.background.name = "background"
        self.background.size = CGSize(width: 775, height: 1007)
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
    }
    
    /**
     Places pieces on screen upon level start up so no pieces overlap or go offscreen
     */
    func placePieces(pieces: [Piece]){
        var count = 0
        var verticalCount = 0
        for piece in pieces {
            piece.position = CGPoint(
                x: Int(size.width/3) * count + 20,
                y: Int(template.position.y) - Int(piece.size.y) * blockSize - 8 - Int(size.height)/5 * verticalCount
            )
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
    
    /**
     Handles double tap gesture to rotate tapped piece
     */
    @objc func handleDoubleTap(_ tap: UITapGestureRecognizer) {
        guard !isFrozen else {
            return
        }
        if tap.state == .ended {
            if let touchedPiece = piece(at: convertPoint(fromView: tap.location(in: self.view))) {
                touchedPiece.zPosition = (touchedPiece.parent?.children.map(\.zPosition).max() ?? 0) + 1
                touchedPiece.shape.rotate()
                
                touchedPiece.position = coordCon.snapToGrid(coord: touchedPiece.position)
                isFrozen = hasWon()
                
               handleOverlap(piece: touchedPiece)
            }
        }
    }
    
    /**
     Handles single tap gesture only on play button to start up new level
     */
    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            if atPoint(convertPoint(fromView: tap.location(in: self.view))) == playButton {
                let nextScene: SKScene
                if levelIndex+1 < allLevels.count {
                    nextScene = GameScene(size: self.size, levelIndex: levelIndex + 1)
                } else {
                    nextScene = HomeScene(size: self.size)
                }
                generateScene(scene: nextScene)
            }
        }
    }
    
    func generateScene(scene: SKScene){
        scene.scaleMode = .aspectFit
        self.view?.presentScene(scene, transition: SKTransition.moveIn(with: SKTransitionDirection.down, duration: 0.5))
    }
    
    /**
     Checks if node at given position is a a piece
     */
    func piece(at pos: CGPoint) -> Piece? {
        let node = atPoint(pos)
        return node.parent as? Piece
    }
    
    /**
     Function to handle tetris piece movement
     */
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
                handleOverlap(piece: touchedBlock)
            }
        }
    }
    
    /**
     If overlap exists, offsets overlapping piece by 10 units in both the x and y direction from the game's grid
     */
    func handleOverlap(piece: Piece){
        if blockPositions.overlap(pieces: piecesList) == true{
            piece.position = CGPoint(x: piece.position.x + 10, y: piece.position.y + 10)
        }
    }

    func winAnimation () {
        addPlayNextLevelButton()
        
        for gridPoint in blockPositions.fillDictionary(piecesList: piecesList).keys {
            let winParticleTop = SKEmitterNode(fileNamed: "Spark.sks")!
            winParticleTop.zPosition = ZPositions.winParticles.rawValue
            // This should be coordCon.gridToScene(gridPoint: gridPoint), but
            // fillDictionary() is really returning CGPoints, not GridPoints
            winParticleTop.position = CGPoint(x: gridPoint.x - blockSize/2 , y: gridPoint.y - blockSize/2)
            addChild(winParticleTop)
            winParticleTop.run(SKAction.fadeIn(withDuration: 10))
        }
    }
    
    func addPlayNextLevelButton () {
        let playHalo = SKSpriteNode(imageNamed: "playHalo")
        playHalo.size = CGSize (width: 200, height: 200)
        playHalo.position = CGPoint(x: 185, y: 160)
        playHalo.zPosition = ZPositions.controls.rawValue
        let playHaloaAnimation = SKAction.sequence([SKAction.rotate(byAngle: 10, duration: 10)])
        playHalo.run(SKAction.repeatForever(playHaloaAnimation))
        addChild(playHalo)
        
        let playButton = SKSpriteNode(imageNamed: "BackB")
        playButton.size = CGSize (width: 78, height: 78)
        playButton.position = CGPoint(x: 185, y: 160)
        playButton.zPosition = ZPositions.controls.rawValue
        let playButtonAnimation = SKAction.fadeIn(withDuration: 0.1)
        addChild(playButton)
        playButton.run(playButtonAnimation)
        
        self.playButton = playButton
    }
    
    func hasWon() -> Bool {
        var won: Bool = true
        let templateMap = blockPositions.fillDictionary(piecesList: piecesList)
        let tempCoords = templateMap.values
        for num in tempCoords{
            if(num != 1){
                won = false
            }
        }
        return won
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
