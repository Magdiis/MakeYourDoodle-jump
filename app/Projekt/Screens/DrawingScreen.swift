//
//  DrawingScreen.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 17.01.2024.
//

import SwiftUI

struct DrawingScreen: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        VStack{
            HStack(){
                Button {
                    appState.switchScene = .CharacterScreen
                    }
                label: {
                    Image(Assets.Textures.backButton)
                }
                Spacer()
            }.padding()
            Spacer()
            SignatureUI()
            Spacer()
        }
     
    }
}

