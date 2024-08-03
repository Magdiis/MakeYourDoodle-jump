//
//  NewRecordScene.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 28.01.2024.
//

import SpriteKit
import GameplayKit

final class NewRecordScene: SKScene {

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
        
        var newRecord = NewRecordNode()
        newRecord.position = CGPoint(x: self.frame.midX, y: self.frame.midY+80)
        newRecord.run(.repeatForever(.sequence([
            .scale(to: 0.5, duration: 1),
            .scale(to: 0.4, duration: 1)
        ])))
        addChild(newRecord)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            newRecord.removeAllActions()
            
            let bestScore = SKLabelNode()
            bestScore.text = "\(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace))"
            bestScore.fontSize = 24.0
            bestScore.fontColor = UIColor.black
            bestScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            
            let tapToContinue = ContinueNode()
            tapToContinue.position = CGPoint(x: self.frame.midX, y: self.frame.midY-80)
            self.addChild(tapToContinue)
            self.addChild(bestScore)
            
        })
         
 
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameState.enter(GameStateInitial.self)
    }
    

}
