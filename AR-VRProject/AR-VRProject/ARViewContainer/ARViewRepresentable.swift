//
//  ARViewRepresentable.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 08.10.2023.
//

import SwiftUI
import RealityKit

struct ARViewRepresentable: UIViewRepresentable {
    
    var vm: ARViewModel
    
    func makeUIView(context: Context) -> ARView {
        vm.startSessionDelegate()
        vm.runSession()
        return vm.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
