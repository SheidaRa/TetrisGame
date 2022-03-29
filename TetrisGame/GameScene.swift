//
//  GameScene.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/16/22.
//

import SpriteKit

class GameScene: SKScene {
    var selectedBlock = Piece()
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override init(size: CGSize) {
      super.init(size: size)
        let tetris = Piece()
        let template = TemplateOutline()
        //template.position = CGPoint(x:size/2, y: size/2)
        
        
        
        self.addChild(template)
        self.addChild(tetris)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,  with event: UIEvent?) {
        let touch = touches.first!
        let positionInScene = touch.location(in:self)

        selectShapeForTouch(touchLocation:positionInScene)
        print("touched")
    }
        
    func selectShapeForTouch(touchLocation: CGPoint) {
        // 1 finds the node @ touchLocation
        let touchedShape = atPoint(touchLocation)

//        if selectedBlock == touchedShape.parent as? TetrisBlock {
        //if selectedBlock == touchedShape.parent as? TetrisBlock {
            // 2 If the node found is a SKSpriteNode instance, check if same as prev selected (if yes, return & do nothing) If no:
            if !selectedBlock.isEqual(touchedShape) {
                selectedBlock.removeAllActions()
                selectedBlock.run(SKAction.rotate(toAngle:0.0,duration: 0.1)) //set it to unrotated state
                //selectedBlock = touchedShape as! TetrisBlock
            }
            
            print("its a tetris piece")
        //}
        
        print("not a tetris piece")
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
