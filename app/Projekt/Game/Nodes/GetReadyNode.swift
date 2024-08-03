//
//  GetReadyNode.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 24.01.2024.
//

 
import SpriteKit

final class GetReadyNode: SKSpriteNode {
    
    
    // MARK: Init
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.initialScene)
        
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
