//
//  DeathCharacter.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 29.01.2024.
//

import SpriteKit

final class DeathCharacterNode: SKSpriteNode {
    
    
    // MARK: Init
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.deathCharacter)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        physicsBody = SKPhysicsBody(
            texture: texture,
            size: texture.size()
        )
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
