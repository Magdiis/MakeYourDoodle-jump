//
//  GameFinished.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 26.01.2024.
//

import SpriteKit
import GameplayKit

final class GameFinishedScene: SKScene {

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
        super.didMove(to: view)
         self.backgroundColor = UIColor.white
         
        var deathCharacter = DeathCharacterNode()
        deathCharacter.position = CGPoint(x: frame.midX, y: frame.height + deathCharacter.size.height/2)
        addChild(deathCharacter)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let gameOverNode = GameOverNode()
            gameOverNode.position = self.center
            gameOverNode.scale(to: CGSize(width: self.size.width/1.4, height: self.size.height/1.4))
            
            let currentScore = SKLabelNode()
            currentScore.text = "\(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.currentScore))"
            currentScore.fontSize = 24.0
            currentScore.fontColor = UIColor.black
            currentScore.position = CGPoint(x: self.frame.midX+40, y: self.frame.midY+71.5)
            
            let bestScore = SKLabelNode()
            bestScore.text = "\(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace))"
            bestScore.fontSize = 24.0
            bestScore.fontColor = UIColor.black
            bestScore.position = CGPoint(x: self.frame.midX+70, y: self.frame.midY+23.5)
            
            self.addChild(gameOverNode)
            self.addChild(currentScore)
            self.addChild(bestScore)
            
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameState.enter(GameStateInitial.self)
    }
    
}

//ScoreNode: SKLabelNode {
//   
//   override init() {
//       super.init()
//       text = "0"
//       fontSize = 24.0
//       fontColor = UIColor.black
//       verticalAlignmentMode = .center
//       horizontalAlignmentMode = .right
//       zPosition = Layer.score
//   }
//   
//   required init?(coder aDecoder: NSCoder) {
//       fatalError("init(coder:) has not been implemented")
//   }
//}
