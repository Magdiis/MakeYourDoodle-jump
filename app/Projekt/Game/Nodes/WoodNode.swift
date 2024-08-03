//
//  WoodNode.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 24.01.2024.
//

import SpriteKit

class WoodNode: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.wood)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.zPosition = Layer.wood
        
        physicsBody = SKPhysicsBody(
            texture: texture,
            size: texture.size()
        )
        physicsBody?.categoryBitMask = Physics.CategoryBitMask.wood
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
}

