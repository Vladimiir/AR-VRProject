//
//  RealityKitViewModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 06.10.2023.
//

import Foundation
import RealityKit
import ARKit
import FocusEntity

class RealityKitViewModel: ObservableObject {
    
    private(set) var arView: ARView
    
    init() {
        arView = ARView()
        
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)
        
        // Set debug options
        #if DEBUG
        arView.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry]
        #endif
        
        runSession()
    }
    
    deinit {
        pauseSession()
    }
    
    func runSession() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
    }
    
    func pauseSession() {
        arView.session.pause()
    }
}
