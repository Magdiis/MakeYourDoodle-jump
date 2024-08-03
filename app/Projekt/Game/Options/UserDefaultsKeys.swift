//
//  UserDefaultsKeys.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 28.01.2024.
//


enum UserDefaultsKeys {}


extension UserDefaultsKeys {
    enum ScoreKeys {
        static let firstPlace = "firstPLace"
        static let secondPlace = "secondPlace"
        static let thirdPlace = "thirdPlace"
        static let currentScore = "currentScore"
        
        static let allValues = [firstPlace, secondPlace, thirdPlace]
    }
}
