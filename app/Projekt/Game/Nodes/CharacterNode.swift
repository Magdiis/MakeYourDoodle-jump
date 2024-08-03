//
//  DefaultCharacter.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 17.01.2024.
//

import SpriteKit

final class CharacterNode: SKSpriteNode, UIAccessibilityIdentification {
    var accessibilityIdentifier: String?
    
    var isCustom: Bool
    
    init(isCustom: Bool){
        self.isCustom = isCustom
        if(self.isCustom){
            let texture = SKTexture(image: loadImage())
            super.init(
                texture: texture,
                color: .clear,
                size: texture.size()
            )
            zPosition = Layer.character
            name = NodeNames.character
            
            physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: texture.size().width,height: 4),
                                        center: CGPoint(x: 0, y: -texture.size().height/2))
            scale(to: CGSize(width: size.width/8, height: size.height/8))
            physicsBody?.affectedByGravity = true
            
            physicsBody?.collisionBitMask = Physics.CategoryBitMask.none

            physicsBody?.categoryBitMask = Physics.CategoryBitMask.character
            physicsBody?.contactTestBitMask = Physics.CategoryBitMask.wood | Physics.CategoryBitMask.bat
            
            
        } else {
            let texture = SKTexture(imageNamed: Assets.Textures.defaultPlayingCharacter)
            super.init(
                texture: texture,
                color: .clear,
                size: texture.size()
            )
            zPosition = Layer.character
            name = NodeNames.character
            
            physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: texture.size().width-40, height: 4), 
                                        center: CGPoint(x: 0, y: -texture.size().height/2))
            
            scale(to: CGSize(width: size.width/1.6, height: size.height/1.6))
            physicsBody?.affectedByGravity = true
            
            physicsBody?.collisionBitMask = Physics.CategoryBitMask.none
            physicsBody?.categoryBitMask = Physics.CategoryBitMask.character
            physicsBody?.contactTestBitMask = Physics.CategoryBitMask.wood | Physics.CategoryBitMask.bat
            
        }
        
        
        func loadImage() -> UIImage {
            if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
                return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("character.png").path()) ?? UIImage()
            } else {
                return UIImage()
            }
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
