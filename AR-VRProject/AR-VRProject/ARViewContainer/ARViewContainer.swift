//
//  ARViewContainer.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 06.10.2023.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    
//    func makeUIView(context: Context) -> ARView {
//
//        let arView = ARView(frame: .zero)
//
//        // Create a cube model
//        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
//        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
//        let model = ModelEntity(mesh: mesh, materials: [material])
//
//        // Create horizontal plane anchor for the content
//        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
//        anchor.children.append(model)
//
//        // Add the horizontal plane anchor to the scene
//        arView.scene.anchors.append(anchor)
//
//        return arView
//
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {}
    
    var arViewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARView {
        arViewModel.startSessionDelegate()
        return arViewModel.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}