//
//  ObjectCaptureContainerViewModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 12.10.2023.
//

import SwiftUI
import RealityKit

@MainActor
class ObjectCaptureContainerViewModel: ObservableObject {
    
    @Published var showReconstructionView = false
    
    /// Handles all capturing and reconstration logic
    @Published var objectCaptureModel = ObjectCaptureModel()
}
