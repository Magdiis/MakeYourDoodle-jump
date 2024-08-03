//
//  CharacterScreen.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 04.01.2024.
//

import SwiftUI
import SpriteKit


struct CharacterScreen: View {
    @EnvironmentObject var appState: AppState
    @State var image: UIImage = UIImage()
    @State var isCustom: Bool = false

    var body: some View {
        VStack{
            HStack{
                Button {
                    appState.switchScene = .MainScreen
                    }
                label: {
                    Image(Assets.Textures.backButton)
                }.padding()
                Spacer()
            }
           
            Spacer()
            
            HStack(alignment: .top){
                
            defaultCharacter(isCustom: $isCustom)
                    .onTapGesture {
                        UserDefaults.standard.set(false, forKey: "customCharacter")
                        refreshIsCustomSet()
                    }
                    .accessibilityIdentifier("defaultCharacterView")
            .onAppear{
                image = loadImage()
                refreshIsCustomSet()
            }
            
            if(image.size.width == 0){
                createCharacter()
                    .environmentObject(appState)
                    .onTapGesture {
                        UserDefaults.standard.set(true, forKey: "customCharacter")
                        refreshIsCustomSet()
                    }
                    
            } else {
              existingCharacter(image: $image, isCustom: $isCustom)
                    .environmentObject(appState)
                    .onTapGesture {
                        UserDefaults.standard.set(true, forKey: "customCharacter")
                        refreshIsCustomSet()
                    }
                    .accessibilityIdentifier("customCharacterView")
            }
                
            }
            Spacer()
        }
       
        
      
    }
    
    func loadImage() -> UIImage {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("character.png").path()) ?? UIImage()
        } else {
            return UIImage()
        }
    }
    
    func isCustomSet() -> Bool {
        return UserDefaults.standard.bool(forKey: "customCharacter")
    }
    
    func refreshIsCustomSet(){
        isCustom = isCustomSet()
    }
}

struct createCharacter: View{
    @EnvironmentObject var appState: AppState
    var body: some View {
        Button(action: {
            appState.switchScene = .DrawingScreen
        }, label: {
            Image(Assets.Textures.createButton)
        })
    }
}

struct existingCharacter: View {
    @EnvironmentObject var appState: AppState
    @Binding var image: UIImage
    @Binding var isCustom: Bool
    var body: some View {
        if (isCustom){
            VStack{
                ZStack{
                    Rectangle()
                        .frame(width: CGFloat(300), height: CGFloat(300))
                        .cornerRadius(15)
                        .foregroundColor(.clear)
                        .overlay{
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.black, lineWidth: 5)
                        }
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230, height: 230)
                        
                }
                Button{
                    appState.switchScene = .DrawingScreen
                }label: {
                    Image(Assets.Textures.refreshButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .padding(.top)

                }
            }.padding(.leading)
           
        } else {
            VStack{
                ZStack{
                    Rectangle()
                        .frame(width: CGFloat(300), height: CGFloat(300))
                        .cornerRadius(15)
                        .foregroundColor(.clear)
                        .overlay{
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray, lineWidth: 5)
                        }
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230, height: 230)
                        
                }
                Button{
                    appState.switchScene = .DrawingScreen
                }label: {
                    Image(Assets.Textures.refreshButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .padding(.top)
                }
            }.padding(.leading)
        }

    }
}
struct defaultCharacter: View {
    @Binding var isCustom: Bool
    var body: some View {
        if (isCustom){
            ZStack{
                Rectangle()
                    .frame(width: CGFloat(300), height: CGFloat(300))
                    .cornerRadius(15)
                    .foregroundColor(.clear)
                    .overlay{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 5)
                    }
                Image(Assets.Textures.defaultCharacter)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230, height: 230)
                 
                    
            }
        } else {
            ZStack{
                Rectangle()
                    .frame(width: CGFloat(300), height: CGFloat(300))
                    .cornerRadius(15)
                    .foregroundColor(.clear)
                    .overlay{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.black, lineWidth: 5)
                    }
                Image(Assets.Textures.defaultCharacter)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230, height: 230)
                    
            }
        }
        
    }
}



