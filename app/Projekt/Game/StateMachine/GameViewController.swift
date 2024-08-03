//
//  GameViewController.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 05.01.2024.
//

import UIKit
import SpriteKit
import GameplayKit

final class GameViewController: UIViewController {
    private let size = CGSize(width: 500, height: 550)
    private lazy var gameState = GKStateMachine(states: [
        GameStateInitial(gameViewController: self),
        GameStateRunning(gameViewController: self),
        GameStateFinished(gameViewController: self),
        GameNewRecordState(gameViewController: self)
    ])
    
    private var skView: SKView {
        view as! SKView
    }
    
    override func loadView() {
        view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameState.enter(GameStateInitial.self)
    }
    
  
}

extension GameViewController {
    func openInitialScene(){
        skView.presentScene(
            GameInitialScene(size: size, gameState: gameState),
            transition: .crossFade(withDuration: 0.5))
    }
    
    func openGameScene(){
        skView.presentScene(
        GameScene(size: size, gameState: gameState))
    }
    
    func openFinishedScene(){
        skView.presentScene(
        GameFinishedScene(size: size, gameState: gameState),
        transition: .crossFade(withDuration: 0.5))
    }
    
    func openNewRecordScene(){
        skView.presentScene(
        NewRecordScene(size: size, gameState: gameState),
        transition: .crossFade(withDuration: 0.5))
    }
}
