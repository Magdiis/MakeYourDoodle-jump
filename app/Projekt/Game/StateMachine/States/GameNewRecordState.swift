//
//  GameNewRecordState.swift
//  Projekt
//
//  Created by Magdaléna Klimešová  on 28.01.2024.
//

import GameplayKit

final class GameNewRecordState: GKState {
    private unowned var gameViewController: GameViewController
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is GameStateInitial.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        gameViewController.openNewRecordScene()
    }
}

