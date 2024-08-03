//
//  MainScreen.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 04.01.2024.
//

import SwiftUI


//@AppStorage vyuzit pro ulozeni path k assetu ktery si uzivatel vybere
struct MainScreen: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
                VStack{
                    Button {
                        appState.switchScene = .GameScreen
                        }
                       label: {
                           Image(Assets.Textures.playButton)
                       // Text("Game Screen")
                       }.padding()
                        .accessibilityIdentifier("GameScreenButton")
                    Button {
                        appState.switchScene = .CharacterScreen
                        }
                       label: {
                           Image(Assets.Textures.characterButton)
                        //Text("Character Screen")
                       }.padding()
                        .accessibilityIdentifier("CharacterScreenButton")
                    
                    Button(action: {
                        appState.switchScene = .ScoreScreen
                    }, label: {
                        Image(Assets.Textures.scoreButton)
                        //Text("Score")
                    }).padding()
                        .accessibilityIdentifier("ScoreScreenButton")
                    
                   // RectangleWithShadow()
                }
       
    }
}

#Preview {
    MainScreen()
}
