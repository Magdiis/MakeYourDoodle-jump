//
//  ScoreScreen.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 28.01.2024.
//

import SwiftUI

struct ScoreScreen: View {
    @EnvironmentObject var appState: AppState
    @State var firstPlace: String = ""
    @State var secondPlace: String = ""
    @State var thirdPlace: String = ""
    var body: some View {
        HStack{
            Button {
                appState.switchScene = .MainScreen
                }
               label: {
                Image(Assets.Textures.backButton)
              }
               .padding()
               .accessibilityIdentifier("BackButtonInScoreScreen")
            Spacer()
        }
        .onAppear{
            firstPlace = "\(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace))"
            secondPlace = "\(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.secondPlace))"
            thirdPlace = "\(UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.thirdPlace))"
        }
        
        Image(Assets.Textures.yourScores)
            .padding()
        Spacer()
        
        Trophy(imageName: Assets.Textures.firstPlace, score: $firstPlace)
        HStack{
            Spacer()
            Trophy(imageName: Assets.Textures.secondPlace, score: $secondPlace)
            Spacer()
            Trophy(imageName: Assets.Textures.thirdPlace, score: $thirdPlace)
            Spacer()
        }
        
        Spacer()
        Spacer()
        
    }
}


struct Trophy: View {
    var imageName: String
    @Binding var score: String
    var body: some View {
        VStack{
            Image(imageName)
                .padding(.bottom)
            Text(score)
                .font(.system(.title, design: .rounded))
                .bold()
        }
    }
}

#Preview {
    ScoreScreen()
}
