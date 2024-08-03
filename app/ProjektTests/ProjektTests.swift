//
//  ProjektTests.swift
//  ProjektTests
//
//  Created by Magdaléna Klimešová on 04.01.2024.
//

import XCTest
import GameplayKit
@testable import Projekt

final class ProjektTests: XCTestCase {
    var gameScene: GameScene!
    var firstPlace: Int!
    var secondPlace: Int!
    var thirdPlace: Int!
    
    override func setUpWithError() throws {
       gameScene = GameScene(size:  CGSize(width: 500, height: 550),
                             gameState: GKStateMachine(states: []))
        firstPlace = UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace)
        secondPlace = UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.secondPlace)
        thirdPlace = UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.thirdPlace)
    }

    override func tearDownWithError() throws {
        gameScene = nil
        firstPlace = nil
        secondPlace = nil
        thirdPlace = nil
    }

    
    func testSavingNewScore(){
        clearScores()
        var newScore = 150
        
        gameScene.saveScoreToUserDefaults(currentScore: newScore)
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace) == newScore)
        
        returnScoresBack()
    }
    
    func testOrderOfSavedScores(){
        clearScores()
        var first = 150
        var second = 100
        var third = 50
        
        gameScene.saveScoreToUserDefaults(currentScore: third)
        gameScene.saveScoreToUserDefaults(currentScore: first)
        gameScene.saveScoreToUserDefaults(currentScore: second)
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace) > UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.secondPlace))
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.secondPlace) > UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.thirdPlace))
        returnScoresBack()
    }
    
    func testLowScore(){
        clearScores()
        let first = 150
        let second = 100
        let third = 50
        gameScene.saveScoreToUserDefaults(currentScore: first)
        gameScene.saveScoreToUserDefaults(currentScore: second)
        gameScene.saveScoreToUserDefaults(currentScore: third)
        
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.thirdPlace) == third)
        
        let low = 20
        gameScene.saveScoreToUserDefaults(currentScore: low)
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace) != low)
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.secondPlace) != low)
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.thirdPlace) != low)
        
        
        returnScoresBack()
    }
    
    func testNewBestScore(){
        clearScores()
        let first = 150
        let second = 100
        let third = 50
        gameScene.saveScoreToUserDefaults(currentScore: first)
        gameScene.saveScoreToUserDefaults(currentScore: second)
        gameScene.saveScoreToUserDefaults(currentScore: third)
        
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace) == first)
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.secondPlace) == second)
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.thirdPlace) == third)
        
        let newBestScore = 200
        gameScene.saveScoreToUserDefaults(currentScore: newBestScore)
        
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace) == newBestScore)
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.secondPlace) == first)
        XCTAssertTrue(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.thirdPlace) == second)
        
        
        returnScoresBack()
    }
    
    
    func returnScoresBack(){
        UserDefaults.standard.set(firstPlace, forKey: UserDefaultsKeys.ScoreKeys.firstPlace)
        UserDefaults.standard.set(secondPlace, forKey: UserDefaultsKeys.ScoreKeys.secondPlace)
        UserDefaults.standard.set(thirdPlace, forKey: UserDefaultsKeys.ScoreKeys.thirdPlace)
    }
    
    func clearScores(){
        UserDefaults.standard.set(0, forKey: UserDefaultsKeys.ScoreKeys.firstPlace)
        UserDefaults.standard.set(0, forKey: UserDefaultsKeys.ScoreKeys.secondPlace)
        UserDefaults.standard.set(0, forKey: UserDefaultsKeys.ScoreKeys.thirdPlace)
    }
    

}

