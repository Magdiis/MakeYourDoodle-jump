//
//  GameStateInitial.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 05.01.2024.
//

import GameplayKit
final class GameStateInitial: GKState {
    private unowned var gameViewController: GameViewController
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is GameStateRunning.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("[GAME STATE] Initial")
        
        gameViewController.openInitialScene()
        
    }
    
}
