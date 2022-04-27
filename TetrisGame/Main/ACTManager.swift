//
//  ACTManager.swift
//  TetrisGame
//
//  Created by Sheida Rashidi Ardestani on 4/26/22.
//

import Foundation
import SpriteKit

class ACTManager{
    
    enum SceneType{
        case MainMenu, GameScene
    }
    
    private init() {}
    static let shared = ACTManager()
    
    
//    func transition ( fromScene: SKScene, toScene: SceneType, transition: SKTransition? = nil ) {
//        guard let scene = getScene(toScene) else {return}
        
//        if let transition = transition {
//            scene.scaleMode = .resizeFill
//            fromScene.view?.presentScene(scene, transition: transition)
//        } else{
//            scene,scaleMode = .resizeFill
//            fromScene.view?.presentScene(scene)
//
//        }
//
//        scene.scaleMode = .resizeFill
//        fromScene.view?.presentScene(scene)
//    }
    
    
//    func getScene ( sceneType: SceneType ) -> SKScene? {
//        switch sceneType {
//        case SceneType.MainMenu:
//            return MainMenu(size: CGSize(width: ScreenSize .width, height: ScreenSize.higth))
//        case SceneType.GameScene:
//            return GameScene(size: CGSize(width: ScreenSize .width, height: ScreenSize.higth))
//        }
//}

}
