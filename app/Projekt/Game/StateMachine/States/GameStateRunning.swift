//
//  GameStateRunning.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 05.01.2024.
//

import GameplayKit

final class GameStateRunning: GKState {
    private unowned var gameViewController: GameViewController
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is GameStateFinished.Type || stateClass is GameNewRecordState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        gameViewController.openGameScene()
    }
}
