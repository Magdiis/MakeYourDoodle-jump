//
//  ContinueNode.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 30.01.2024.
//

import SpriteKit

final class ContinueNode: SKSpriteNode {
    
    
    // MARK: Init
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.tapToContinue)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        physicsBody = SKPhysicsBody(
            texture: texture,
            size: texture.size()
        )
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        scale(to: CGSize(width: size.width/2, height: size.height/2))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
