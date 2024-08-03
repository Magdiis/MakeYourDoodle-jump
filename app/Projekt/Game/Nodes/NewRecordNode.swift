//
//  NewRecordNode.swift
//  Projekt
//
//  Created by Magdaléna Klimešová  on 28.01.2024.
//


import SpriteKit

final class NewRecordNode: SKSpriteNode {
   
    
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.newRecord)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        physicsBody = SKPhysicsBody(
            texture: texture,
            size: texture.size()
        )
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        scale(to: CGSize(width: size.width/5, height: size.height/5))
        
    }
    
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   
}

