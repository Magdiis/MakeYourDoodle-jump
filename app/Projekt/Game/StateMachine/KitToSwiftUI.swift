//
//  KitToSwiftUI.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 05.01.2024.
//

import SwiftUI

struct KitToSwiftUI: UIViewControllerRepresentable {
    typealias UIViewControllerType = GameViewController
    
    func makeUIViewController(context: Context) -> GameViewController {
        let vc = GameViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        return
    }
    
   
}
