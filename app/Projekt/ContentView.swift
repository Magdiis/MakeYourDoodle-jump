//
//  ContentView.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 04.01.2024.
//

import SwiftUI
import SpriteKit


class AppState: ObservableObject {
    enum CurrentView: Int {
        case MainScreen
        case CharacterScreen
        case GameScreen
        case DrawingScreen
        case ScoreScreen
    }
    
 //   @AppStorage("scene") var switchSceneApp = CurrentView.MainScreen
    @Published var switchScene = CurrentView.MainScreen
}



struct ContentView: View {
    @StateObject var appState = AppState()
    var body: some View{
        //Group {
                    switch (appState.switchScene) {
                    case .MainScreen:
                        MainScreen()
                            .environmentObject(appState)
                           
                    case .CharacterScreen:
                        CharacterScreen()
                            .environmentObject(appState)
                         
                        
                    case .GameScreen:
                        GameScreen()
                            .environmentObject(appState)
                        
                    case .DrawingScreen:
                        DrawingScreen()
                            .environmentObject(appState)
                        
                    case .ScoreScreen:
                        ScoreScreen()
                            .environmentObject(appState)
                    }
        //        }
        
    }
    
}


