//
//  ARVideModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 05.10.2023.
//

import SwiftUI
import RealityKit
import ARKit

class ARViewModel: UIViewController, ObservableObject {
    
    @Published private var model = ARModel()
    
    var arView: ARView {
        model.arView
    }
    
    var imageRecognizedVar: Bool {
        model.imageRecognizedVar
    }
    
    var imageRecognizedTuple: (title: String,
                               color: Color) {
        (imageRecognizedVar ? "Yes" : "No",
         imageRecognizedVar ? .green : .red)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        model.arView.session.delegate = self
        runSession()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        pauseSession()
    }
    
    func runSession() {
        startSessionDelegate()
        model.runSession()
    }
    
    func pauseSession() {
        model.pauseSession()
    }
    
    func reset() {
        model.imageRecognizedVar = false
    }
    
    func startSessionDelegate() {
        model.arView.session.delegate = self
    }
}

extension ARViewModel: ARSessionDelegate {
    
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
