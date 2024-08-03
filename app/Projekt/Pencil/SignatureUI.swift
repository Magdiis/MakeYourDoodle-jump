//
//  SignatureUI.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 05.01.2024.
//

import SwiftUI
import PencilKit

struct SignatureUI: View {
    @EnvironmentObject var appState: AppState
    @State var canvasView = PencilKitRepresentable()
    let imgRect = CGRect(x: 25, y: 25, width: 500, height: 650)
    @State var image: UIImage = UIImage()

    var body: some View {
        HStack(alignment:.top){
            VStack(alignment: .leading){
                DrawingCharacterView(canvasView: $canvasView)
                Button(action: {
                    saveSignature()
                }, label: {
                    Image(Assets.Textures.saveButton)
                }).padding(.top)
            }
            
            Tools(canvasView: $canvasView)
        }

            
        
        
            
    }
    
    func saveSignature() {
        if(canvasView.canvas.drawing.strokes.isEmpty){
            appState.switchScene = .CharacterScreen
        } else {
            let image = canvasView.canvas.drawing.image(from: imgRect, scale: 1.0)
            //let strokes = canvasView.canvas.drawing.strokes
            let pngImageData = image.pngData()
            let filename = getDocumentsDirectory().appendingPathComponent("character.png")
            try? pngImageData?.write(to: filename)
            UserDefaults.standard.set(true, forKey: "customCharacter")
            appState.switchScene = .CharacterScreen
            }
        }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask)
        return paths[0]
    }
    
    func loadImage() -> UIImage {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("character.png").path()) ?? UIImage()
        } else {
            return UIImage()
        }
    }
}


struct DrawingCharacterView: View {
    @Binding var canvasView: PencilKitRepresentable
    var body: some View {
        ZStack(alignment: .center) {
        Rectangle()
            .fill(.clear)
            .frame(width: 500, height: 650)
            .border(Color.black, width: 1)
            .opacity(0.5)
        Image(Assets.Textures.defaultCharacter)
            .resizable()
            .scaledToFit()
            .frame(width: 500, height: 650)
            .opacity(0.03)
        canvasView
            .border(Color.gray, width: 5)
            .frame(width: 550, height: 700)
       
        }
    }
}

struct Tools: View {
    @Binding var canvasView: PencilKitRepresentable
    @State var isPenOn: Bool = true
    var body: some View {
        VStack{
            Button(action: {
                canvasView.canvas.tool = PKInkingTool(.pen, color: .black, width: 200)
                isPenOn = true
            }, label: {
                if (isPenOn){
                    Image(Assets.Textures.penOn)
                } else {
                    Image(Assets.Textures.penOff)
                }
                
            }).padding([.leading,.bottom])
            Button(action: {
                canvasView.canvas.tool = PKEraserTool( PKEraserTool.EraserType.bitmap )
                isPenOn = false
            }, label: {
                if (isPenOn){
                    Image(Assets.Textures.eraserOff)
                } else {
                    Image(Assets.Textures.eraserOn)
                }
                
            }).padding([.leading,.top])
        }
    }
}




