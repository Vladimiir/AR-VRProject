//
//  ARViewContainer.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 06.10.2023.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
        
    var vm: ARViewModel
    
    func makeUIView(context: Context) -> ARView {
        vm.startSessionDelegate()
        return vm.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
