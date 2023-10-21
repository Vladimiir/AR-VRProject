//
//  ObjectCaptureContainerViewModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 12.10.2023.
//

import SwiftUI
import RealityKit
import Combine

@MainActor
class ObjectCaptureContainerViewModel: ObservableObject {
    
    @Published var showObjectCapturePointCloudView = false
    @Published var showReconstructionView = false
    
    /// Handles all capturing and reconstration logic
    @Published var objectCaptureModel = ObjectCaptureModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    var canShowContinueButton: Bool {
        objectCaptureModel.session?.state == .ready
    }
    
    var canShowStartCaptureButton: Bool {
        objectCaptureModel.session?.state == .detecting
    }
    
    init() {
        addListeners()
    }
    
    private func addListeners() {
        objectCaptureModel.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &cancellables)
        
        // Observing for 'userCompletedScanPassUpdates' updates and do the next step
        Task {
            if let objectCaptureSession = objectCaptureModel.session {
                for await scanPassUpdate in objectCaptureSession.userCompletedScanPassUpdates {
                    print("scanPassUpdate = \(scanPassUpdate)")
                    showObjectCapturePointCloudView = true
                    objectCaptureSession.pause()
                }
            }
        }
    }
    
    func finishButtonAction() {
        objectCaptureModel.session?.finish()
        showReconstructionView = true
    }
    
    func continueButtonAction() {
        let _ = objectCaptureModel.session?.startDetecting()
    }
    
    func startCaptureButtonAction() {
        objectCaptureModel.session?.startCapturing()
    }
    
    func resetButtonAction() {
        objectCaptureModel.session?.resetDetection()
    }
}
