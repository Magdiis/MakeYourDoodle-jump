//
//  Physics.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 24.01.2024.
//

import CoreGraphics

enum Physics {}

extension Physics {
    
    enum CategoryBitMask {
        static let none: UInt32 = 0
        static let character: UInt32 = 0x1
        static let wood: UInt32 = 0x1 << 1
        static let bottom: UInt32 = 0x1 << 2
        static let rocket: UInt32 = 0x1 << 3
        static let bat:  UInt32 = 0x1 << 4
        static let hitByBat: UInt32 = 0x1 << 5
    }
}
