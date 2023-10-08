//
//  RealityKitView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 06.10.2023.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct RealityKitView: UIViewRepresentable {
    
    @StateObject var vm = RealityKitViewModel()
    
    func makeUIView(context: Context) -> ARView {
        context.coordinator.view = vm.arView
        vm.arView.session.delegate = context.coordinator
        return vm.arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ view: ARView, context: Context) {}
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: FocusEntity?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
        }
    }
}
