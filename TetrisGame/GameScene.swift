//
//  GameScene.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/16/22.
//

import SpriteKit

class GameScene: SKScene {
    var selectedBlock = SKShapeNode()
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override init(size: CGSize) {
      super.init(size: size)
        let tetris = TetrisBlock.init(size: size)
        
        self.addChild(tetris)
        
        block.position = CGPoint(x: size.width, y: size.height)
        let singleblock = SKShapeNode(rect: CGRect(x: size.width/2, y: size.width/2, width: 40, height: 40))
        singleblock.fillColor = SKColor.white
        singleblock.lineWidth = CGFloat(5.0)
        singleblock.strokeColor = SKColor.red
        
        self.addChild(singleblock)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>,  with event: UIEvent?) {
            let touch = touches.first!
            let positionInScene = touch.location(in:self)

            selectShapeForTouch(touchLocation:positionInScene)

        }
        
    func selectShapeForTouch(touchLocation: CGPoint) {
        // 1 finds the node @ touchLocation
        let touchedShape = atPoint(touchLocation)

        if touchedShape is SKShapeNode {
            // 2 If the node found is a SKSpriteNode instance, check if same as prev selected (if yes, return & do nothing) If no:
            if !selectedBlock.isEqual(touchedShape) {
                selectedBlock.removeAllActions()
                selectedBlock.run(SKAction.rotate(toAngle:0.0,duration: 0.1)) //set it to unrotated state
                selectedBlock = touchedShape as! SKShapeNode
            }
        }
    }
    
    func panForTranslation(translation: CGPoint) {
        let position = selectedBlock.position
          
        selectedBlock.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
              
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first! //unwrapping optional type 'UITouch?' by Force-unwrap using '!' to abort execution if the optional value contains 'nil'
            let positionInScene = touch.location(in:self)
            let previousPosition = touch.previousLocation(in:self)
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
          
            panForTranslation(translation:translation)
        }

}
