//
//  ProjektUITests.swift
//  ProjektUITests
//
//  Created by Magdaléna Klimešová on 04.01.2024.
//

import XCTest

final class ProjektUITests: XCTestCase {
    var app: XCUIApplication!
    
    var characterButton: XCUIElement {
        app.buttons["CharacterScreenButton"]
    }
    
    var gameButton: XCUIElement {
        app.buttons["GameScreenButton"]
    }
    var scoreButton: XCUIElement {
        app.buttons["ScoreScreenButton"]
    }
    
    var backButtonInScoreScreen: XCUIElement {
        app.buttons["BackButtonInScoreScreen"]
    }
    
    var characterNode: XCUIElement {
        app.otherElements["characterNode"]
    }
    
    var gameInitialScene: XCUIElement {
        app.otherElements["GameInitialScene"]
    }
    

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
         app = nil
    }
    
    // TESTING MY OWN NAVIGATION
    func testNavigation() throws{
        XCTAssert(gameButton.exists)
        XCTAssert(characterButton.exists)
        XCTAssert(scoreButton.exists)
        
        scoreButton.tap()
        //NAVIGATE TO SCORE SCREEN
        XCTAssert(backButtonInScoreScreen.exists)
        //NAVIGATE BACK
        backButtonInScoreScreen.tap()
        
        XCTAssert(gameButton.exists)
        XCTAssert(characterButton.exists)
        XCTAssert(scoreButton.exists)
        
    }
    
    //TESTING STATE MACHINE
    //TESTING INITING CHARACTER IN GAME RUNNING STATE
    func testStateMachineAndInitingCharacter(){
        XCTAssert(gameButton.exists)
        gameButton.tap()
        XCTAssert(gameInitialScene.waitForExistence(timeout: 1))
        gameInitialScene.tap()
        XCTAssert(characterNode.waitForExistence(timeout: 1))
    }
    
}
