//
//  GameInitialScreen.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 05.01.2024.
//

import SpriteKit
import GameplayKit

final class GameInitialScene: SKScene, UIAccessibilityIdentification {
    var accessibilityIdentifier: String?
    

    private let gameState: GKStateMachine
    

    init(
        size: CGSize,
        gameState: GKStateMachine
    ) {
        self.gameState = gameState
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        
        scaleMode = .aspectFill
    }
    
    override func didMove(to view: SKView) {
       super.didMove(to: view)
        
         self.backgroundColor = UIColor.white
        isAccessibilityElement = true
        accessibilityIdentifier = "GameInitialScene"
        
         
         var getReadyNode = GetReadyNode()
         getReadyNode.position = center
        getReadyNode.scale(to: CGSize(width: size.width/1.4, height: size.height/1.4))
         addChild(getReadyNode)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("[ENTER] GameStateRunning")
        gameState.enter(GameStateRunning.self)
    }
    
}

