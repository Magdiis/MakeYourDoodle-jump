//
//  SpriteKitContainer.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 05.01.2024.
//
//
//import SwiftUI
//import SpriteKit
//
//struct SpriteKitContainer : UIViewRepresentable {
//    typealias UIViewType = SKView
//    var skScene: SKScene!
//    
//    init(scene: SKScene) {
//        skScene = scene
//        self.skScene.scaleMode = .resizeFill
//    }
//    
//    
//    class Coordinator: NSObject {
//        var scene: SKScene?
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        let coordinator = Coordinator()
//        coordinator.scene = self.skScene
//        return coordinator
//    }
//    
//    func makeUIView(context: Context) -> SKView {
//        let view = SKView(frame: .zero)
//        //view.preferredFramesPerSecond = 60
//        return view
//    }
//    
//    func updateUIView(_ uiView: SKView, context: Context) {
//        uiView.presentScene(context.coordinator.scene)
//    }
//    
//    
//    
//    
//    
//}
