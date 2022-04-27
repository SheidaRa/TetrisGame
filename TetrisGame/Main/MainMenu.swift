//
//  MainMenu.swift
//  TetrisGame
//
//  Created by Sheida Rashidi Ardestani on 4/26/22.
//

import SpriteKit


class MainMenu: SKScene {
    override func didMove (to view:SKView){
        print("this is mainMenu")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == touches.first{
                print("going to Gameplay")
                ACTManager.shared.transition(fromScene: self , toScene: .MainMenu, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
            }
        }
    }
}
 
