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
    
    private(set) var arView: ARView
    
    var imageRecognizedVar = false
    
    init() {
        guard let trackerImage = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources",
                                                                  bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = trackerImage
        
        arView = ARView(frame: .zero)
        arView.session.run(configuration)
    }
    
    mutating func imageRecognized(anchors: [ARAnchor]) {
        guard let _ = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        imageRecognizedVar = anchors.contains(where: { ($0 as? ARImageAnchor) != nil })
    }
}
