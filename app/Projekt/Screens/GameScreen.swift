//
//  GameScreen.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 04.01.2024.
//

import SwiftUI
import SpriteKit
import GameplayKit

struct GameScreen: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        HStack{
            Button {
                appState.switchScene = .MainScreen
                }
               label: {
                   Image(Assets.Textures.backButton)
               }.padding([.leading, .top])
            Spacer()
        }
       
        KitToSwiftUI()
            .ignoresSafeArea()
           
        
    }
}
