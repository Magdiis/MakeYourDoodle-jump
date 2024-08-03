//
//  PencilKitRepresentable.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 05.01.2024.
//

import Foundation
import UIKit
import PencilKit
import SwiftUI

struct PencilKitRepresentable: UIViewRepresentable {
    
    let canvas = PKCanvasView(frame: .init(x: 0, y: 0, width: 550, height: 700))
    
    func makeUIView(context: Context) -> some PKCanvasView {
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.tool = PKInkingTool(.pen, color: .black, width: 200)
        return canvas
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
