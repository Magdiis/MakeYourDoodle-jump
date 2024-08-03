//
//  Level.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 28.01.2024.
//

import Foundation

enum Level {}

extension Level {
    enum spaceBetween{
        static let easy = CGFloat.random(in: CGFloat(40)...CGFloat(60))
        static let medium = CGFloat.random(in: CGFloat(60)...CGFloat(75))
        static let hard = CGFloat.random(in: CGFloat(80)...CGFloat(80))
    }
}


extension Level {
    enum score {
        static let easy = 500 // easy space between
        static let medium = 1000 // medium space between
        static let hard = 1500 //hard space between
        static let movingPlatforms = 3000 // moving platforms - clouds
        static let disappearingPlatforms = 6000 // rockets
    }
}
