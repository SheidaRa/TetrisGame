//
//  GameViewController.swift
//  TetrisGame
//
//  Created by Tenzin Gyaltsen on 3/16/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "HomeScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                scene.backgroundColor = SKColor.black
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true

        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillLayoutSubviews() {
      // Configure the view.
      let skView = self.view as! SKView
        
      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true
        
      let scene = HomeScene(size: CGSize(width: 375, height: 667))
      /* Set the scale mode to scale to fit the window */
      scene.scaleMode = .aspectFit
      skView.presentScene(scene)
    }
}





