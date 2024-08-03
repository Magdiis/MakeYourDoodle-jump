//
//  ScoreNode.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 27.01.2024.
//

import SpriteKit

final class ScoreNode: SKLabelNode {
    
    override init() {
        super.init()
        text = "0"
        fontSize = 24.0
        fontColor = UIColor.black
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .right
        zPosition = Layer.score
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
