//
//  FinishNode.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 26.01.2024.
//

import SpriteKit

final class GameOverNode: SKSpriteNode {
    
    
    // MARK: Init
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.gameOver)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        physicsBody = SKPhysicsBody(
            texture: texture,
            size: texture.size()
        )
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
