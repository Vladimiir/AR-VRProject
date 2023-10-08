//
//  ARModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 05.10.2023.
//

import Foundation
import RealityKit
import ARKit

struct ARModel {
    
    private(set) var arView = ARView()
    private var configuration: ARWorldTrackingConfiguration = {
        guard let trackerImage = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources",
                                                                  bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = trackerImage
        return configuration
    }()
    
    var imageRecognizedVar = false
    
    init() {
        runSession()
    }
    
    func runSession() {
        arView.session.run(configuration)
    }
    
    func pauseSession() {
        arView.session.pause()
        arView.session.run(configuration, options: .removeExistingAnchors)
    }
    
    mutating func imageRecognized(anchors: [ARAnchor]) {
        guard let _ = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        imageRecognizedVar = anchors.contains(where: { ($0 as? ARImageAnchor) != nil })
    }
}
