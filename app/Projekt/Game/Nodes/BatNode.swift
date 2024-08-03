//
//  batNode.swift
//  Projekt
//
//  Created by  Magdaléna Klimešová  on 30.01.2024.
//

import SpriteKit

class BatNode: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.bat)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.zPosition = Layer.wood
        
        physicsBody = SKPhysicsBody(
            texture: texture,
            size: texture.size()
        )
        scale(to: CGSize(width: size.width/9, height: size.height/9))
        physicsBody?.categoryBitMask = Physics.CategoryBitMask.bat
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.contactTestBitMask = Physics.CategoryBitMask.character
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
}
