//
//  ARVideModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 05.10.2023.
//

import Foundation
import RealityKit
import ARKit

class ARViewModel: UIViewController, ObservableObject, ARSessionDelegate {
    
    @Published private var model = ARModel()
    
    var arView: ARView {
        model.arView
    }
    
    var imageRecognizedVar: Bool {
        model.imageRecognizedVar
    }
    
    func reset() {
        model.imageRecognizedVar = false
    }
    
    func startSessionDelegate() {
        model.arView.session.delegate = self
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        model.imageRecognized(anchors: anchors)
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        model.imageRecognized(anchors: anchors)
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        model.imageRecognized(anchors: anchors)
    }
}
